# ----------------------------
# Elastic Beanstalk for Nuxt Frontend
# ----------------------------
# Hosts your Nuxt SSR app as a managed Node.js environment.

resource "aws_elastic_beanstalk_application" "frontend" {
  name        = "${var.project_name}-frontend"
  description = "Nuxt SSR frontend app"
}

resource "aws_elastic_beanstalk_environment" "frontend_env" {
  name                = "${var.project_name}-frontend-env"
  application         = aws_elastic_beanstalk_application.frontend.name
  solution_stack_name = "64bit Amazon Linux 2 v5.8.6 running Node.js 18"
  tier                = "WebServer"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.main.id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", aws_subnet.public[*].id)
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.frontend.id
  }

  tags = {
    Name = "${var.project_name}-frontend-env"
  }
}