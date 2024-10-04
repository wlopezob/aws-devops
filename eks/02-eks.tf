## Create the EKS cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = "${var.project_name_prefix}-eks-cluster"
  role_arn = var.role_arn_cluster

  vpc_config {
    subnet_ids = [
      aws_subnet.sb-private-01.id,
      aws_subnet.sb-private-02.id
    ]
    endpoint_private_access = true
    endpoint_public_access  = false
  }
  version = var.cluster_version
  access_config {
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  depends_on = [ aws_subnet.sb-private-01 ]
}

### create role group
resource "aws_iam_role" "role" {
  name = "${var.project_name_prefix}-role-ec2"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "role-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.role.name
}

resource "aws_iam_role_policy_attachment" "role-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.role.name
}

resource "aws_iam_role_policy_attachment" "role-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.role.name
}



## create node group private
resource "aws_eks_node_group" "eks-node-group-private" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "${var.project_name_prefix}-eks-node-group-private"
  version         = aws_eks_cluster.eks-cluster.version
  node_role_arn   = aws_iam_role.role.arn
  subnet_ids = [
    aws_subnet.sb-private-01.id,
    aws_subnet.sb-private-02.id
  ]

  instance_types = [
    "${var.instance_type}"
  ]

  scaling_config {
    desired_size = var.node_count
    max_size     = var.node_count
    min_size     = var.node_count
  }

  tags = {
    Name        = "${var.project_name_prefix}-eks-node-group-private"
    Environment = "Dev"
  }

}