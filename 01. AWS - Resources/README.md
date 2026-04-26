# 01. AWS - Resources

This example shows a minimal Terraform deployment of a single EC2 instance in AWS.

## What it creates

- `aws_instance.terraform-test` (Ubuntu 24.04 LTS, `t3.micro`)

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

## Notes

- You need AWS credentials configured (for example via `AWS_ACCESS_KEY_ID`/`AWS_SECRET_ACCESS_KEY` or an AWS profile).
