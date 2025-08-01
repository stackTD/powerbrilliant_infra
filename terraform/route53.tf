# ----------------------------
# Route 53: DNS for your domain
# ----------------------------
# This creates (or references) a Route 53 hosted zone and an A record to point to your frontend load balancer.

# If you already have the domain registered in Route 53, use 'data' instead of 'resource'.
resource "aws_route53_zone" "main" {
  name = var.route53_domain # e.g. "example.com"
}

# Sample A record for your frontend (Beanstalk LB)
resource "aws_route53_record" "frontend" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.route53_domain # root domain, or use "www" for www.example.com
  type    = "A"

  alias {
    name                   = aws_elastic_beanstalk_environment.frontend_env.endpoint_url
    zone_id                = aws_elastic_beanstalk_environment.frontend_env.cname
    evaluate_target_health = true
  }
}