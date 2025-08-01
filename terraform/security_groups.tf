# ----------------------------
# Security Groups
# ----------------------------

# Allow inbound Postgres only from private EC2 backend
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow Postgres only from backend"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Postgres from EC2 backend"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups  = [aws_security_group.backend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

# Allow inbound HTTP from public LB (Beanstalk) and SSH from your IP
resource "aws_security_group" "backend" {
  name        = "${var.project_name}-backend-sg"
  description = "Allow HTTP from LB, SSH from your IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from LB"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # For now, allow all traffic—replace with ELB SG for best security
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_PUBLIC_IP/32"] # <-- Change this!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-backend-sg"
  }
}

# Allow HTTP/HTTPS to frontend (Beanstalk)
resource "aws_security_group" "frontend" {
  name        = "${var.project_name}-frontend-sg"
  description = "Allow HTTP/HTTPS to frontend"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-frontend-sg"
  }
}