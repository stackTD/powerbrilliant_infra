# Define all customizable variables here

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix for all resources"
  default     = "powerbrilliant"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "db_username" {
  description = "RDS master username"
  default     = "postgres"
}

variable "db_password" {
  description = "RDS master password"
  sensitive   = true
}

variable "db_name" {
  description = "RDS database name"
  default     = "powerbrilliantdb"
}