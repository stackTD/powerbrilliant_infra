# AWS Production Architecture with Terraform

This set of Terraform scripts will help you create the AWS resources shown in your architecture diagram.

## 💡 Steps to Use

1. **Install Terraform**  
   [Terraform Download](https://www.terraform.io/downloads.html)

2. **Clone your repo and enter the infra directory**

3. **Configure your AWS credentials**  
   ```bash
   aws configure
   ```
   or set environment variables:
   ```bash
   export AWS_ACCESS_KEY_ID=YOUR_KEY
   export AWS_SECRET_ACCESS_KEY=YOUR_SECRET
   export AWS_DEFAULT_REGION=us-east-1
   ```

4. **Initialize Terraform**
   ```bash
   terraform init
   ```

5. **Review and apply the plan**
   ```bash
   terraform plan
   terraform apply
   ```

6. **(Optional) Destroy resources**
   ```bash
   terraform destroy
   ```

## 🚩 Directory Structure

- `main.tf` — Root module, includes submodules
- `variables.tf` — All variables (edit for your use)
- `outputs.tf` — Useful outputs for your stack

Each major AWS service (VPC, RDS, EC2, Beanstalk, Route53, etc.) will be in its own module or file for clarity.

---

**Start by editing `variables.tf` to match your needs (VPC CIDR, instance type, DB name, etc.).**  
Then run the steps above!

---