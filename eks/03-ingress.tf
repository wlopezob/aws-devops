provider "kubernetes" {
  host                   = aws_eks_cluster.eks-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args = ["eks", "get-token", "--cluster-name", aws_eks_cluster.eks-cluster.name,
    "--region", var.region]
    command = "aws"
  }
}

provider "helm" {
  experiments {
    manifest = true
  }
  kubernetes {
    host                   = aws_eks_cluster.eks-cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args = ["eks", "get-token", "--cluster-name", aws_eks_cluster.eks-cluster.name,
      "--region", var.region]
      command = "aws"
    }
  }
}

# install ingress controller - nginx
resource "helm_release" "ingress-nginx" {
  name = "ingress-nginx"
  #repository = "https://kubernetes.github.io/ingress-nginx"
  chart            = "./charts/ingress-nginx-4.10.0"
  namespace        = "ingress"
  create_namespace = true
  timeout          = 1800
  version          = "4.10.0"
  values = [
    "${file("./ingress-nginx/chart_values.yaml")}"
  ]
  set {
    name  = "cluster.enabled"
    value = "true"
  }
  # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/guide/service/annotations/
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-name"
    value = "${var.project_name_prefix}-nlb"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-subnets"
    value = "${aws_subnet.sb-private-01.id}\\,${aws_subnet.sb-private-02.id}"
  }

  # set {
  #   name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-subnets"
  #   value = "${aws_subnet.sb-public-01.id}\\,${aws_subnet.sb-public-02.id}"
  # }
 
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-additional-resource-tags"
    value = "Name=${var.project_name_prefix}-nlb"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = var.cm-arn
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal"
    value = "true"
  }

  set {
    name  = "controller.service.internal.enabled"
    value = "true"
  }
  
  depends_on = [aws_eks_node_group.eks-node-group-private]
}

data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress"
  }
  depends_on = [helm_release.ingress-nginx]
}