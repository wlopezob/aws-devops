data "aws_route53_zone" "main-domain" {
  name = var.main_domain
}

resource "aws_route53_record" "record" {
  zone_id         = data.aws_route53_zone.main-domain.zone_id
  name            = aws_api_gateway_domain_name.custom_domain-gw.domain_name
  type            = "A"
  allow_overwrite = true
  alias {
    name                   = aws_api_gateway_domain_name.custom_domain-gw.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.custom_domain-gw.regional_zone_id
    evaluate_target_health = true
  }
  depends_on = [aws_api_gateway_domain_name.custom_domain-gw]
}