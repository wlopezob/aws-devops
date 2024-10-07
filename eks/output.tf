# output "aws_loadbalancer_uri" {
#   value =  "http://${data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname}"
# }