# ----------------------------
# Amazon RDS (Postgres) Setup
# ----------------------------
# This creates a managed PostgreSQL DB in the private subnet.

resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-rds-subnet-group"
  subnet_ids = aws_subnet.private[*].id
  tags = {
    Name = "${var.project_name}-rds-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier              = "${var.project_name}-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = "db.t3.micro"
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true # For dev/test; set to false for prod!
  publicly_accessible     = false
  multi_az                = false
  storage_encrypted       = true
  backup_retention_period = 7
  deletion_protection     = false # For dev/test; set to true for prod!
  tags = {
    Name = "${var.project_name}-rds"
  }
}