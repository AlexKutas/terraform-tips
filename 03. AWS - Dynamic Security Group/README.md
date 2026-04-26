# 03. AWS - Dynamic Security Group

This example demonstrates Terraform `dynamic` blocks by generating multiple ingress rules inside a single Security Group.

## What it creates

- `aws_security_group.dynamic_sg`
  - Dynamic ingress for ports: `25, 53, 80, 443, 465, 993` from `0.0.0.0/0`
  - Static ingress: SSH `22` from `10.10.0.0/16`
  - Egress: all traffic

Region: `eu-central-1` (Frankfurt).

## How to run

```bash
terraform init
terraform plan
terraform apply
```

## How to destroy

```bash
terraform destroy
```
