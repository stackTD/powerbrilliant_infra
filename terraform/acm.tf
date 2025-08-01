# ----------------------------
# ACM: SSL/TLS Certificate for your domain
# ----------------------------
# This creates a certificate for your domain and a DNS validation record.

resource "aws_acm_certificate" "frontend" {
  domain_name               = var.route53_domain
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_acm_certificate.frontend.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.frontend.domain_validation_options[0].resource_record_type
  records = [aws_acm_certificate.frontend.domain_validation_options[0].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "frontend" {
  certificate_arn         = aws_acm_certificate.frontend.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}