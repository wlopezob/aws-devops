data "aws_lb" "nlb" {
  name       = split("-", data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname)[0]
  depends_on = [helm_release.ingress-nginx]
}


locals {
  nlb_name = split("-", data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname)[0]
}

## wait until to create the NLB
resource "null_resource" "wait_for_nlb" {
  depends_on = [helm_release.ingress-nginx]

  provisioner "local-exec" {
    command = <<EOT
    # Añade un chequeo que verifique que el NLB esté activo antes de continuar
    state=$(aws elbv2 describe-load-balancers --names ${local.nlb_name} --region ${var.region} --query 'LoadBalancers[0].State.Code' --output text)
    while [ "$state" != "active" ]; do
        echo "Esperando a que el NLB esté activo..."
        sleep 10
        state=$(aws elbv2 describe-load-balancers --names ${local.nlb_name} --region ${var.region} --query 'LoadBalancers[0].State.Code' --output text)
    done
    echo "NLB activo"
    EOT
  }
}

resource "aws_api_gateway_vpc_link" "vpc-link" {
  name        = "${var.project_name_prefix}-vpc-link"
  target_arns = [data.aws_lb.nlb.arn]
  tags = {
    Name = "${var.project_name_prefix}-vpc-link"
  }
  depends_on = [null_resource.wait_for_nlb]
}


resource "aws_api_gateway_domain_name" "custom_domain-gw" {
  domain_name = var.custom_domain

  regional_certificate_arn = var.cm-arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

