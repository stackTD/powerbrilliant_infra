# Useful outputs for reference

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "backend_alb_dns" {
  value = aws_lb.backend.dns_name
}

output "frontend_beanstalk_url" {
  value = aws_elastic_beanstalk_environment.frontend_env.endpoint_url
}

output "route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "acm_cert_arn" {
  value = aws_acm_certificate_validation.frontend.certificate_arn
}