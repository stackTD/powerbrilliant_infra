# ----------------------------
# EC2 Instance for Rust Backend
# ----------------------------
# This launches a t3.micro EC2 instance in the private subnet.

resource "aws_instance" "backend" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.backend.id]
  associate_public_ip_address = false
  key_name               = var.ec2_key_name # You must create/upload this key pair first.

  tags = {
    Name = "${var.project_name}-backend"
  }

  # User data for provisioning (customize for your app)
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              # Add more setup here: pull/build/start your Rust app etc.
              EOF
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

variable "ec2_key_name" {
  description = "SSH key pair name to access EC2"
  type        = string
}