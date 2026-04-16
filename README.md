# Terraform AWS Lessons

A collection of small Terraform examples for AWS. Each numbered folder is a standalone lesson with its own `main.tf` (and sometimes `variables.tf`, `outputs.tf`, templates, or scripts).

## Prerequisites

- Terraform installed (`terraform -version`)
- An AWS account + credentials configured (for example via environment variables or an AWS profile)
- Permissions to create resources like EC2, VPC, Security Groups, ALB, ASG, EIP

## Repository structure

- `1. AWS - Resources`: minimal EC2 instance
- `2. AWS - WebServer`: EC2 + Security Group + `user_data` from a template
- `3. AWS - Dynamic Security Group`: `dynamic` ingress rules in a Security Group
- `4. AWS - Life Cicle & Output`: `lifecycle` settings + outputs + EIP
- `5. AWS - Depends On`: explicit resource ordering via `depends_on`
- `6. AWS - Data Source`: data sources (AMIs/AZs/account/region/VPCs) + sample VPC/subnets
- `7. AWS - Green & Blue`: ALB + Launch Template + Auto Scaling Group in a VPC (good base for blue/green-style iterations)
- `8. AWS - Variables`: variables, locals, tags merging, and `.auto.tfvars` environments
- `9. AWS - Exec Local`: `null_resource` + `local-exec` logging during apply

Each folder also contains its own `README.md` with details.

## How to run any lesson

From the repo root:

```bash
cd "N. AWS - <Lesson Name>"
terraform init
terraform plan
terraform apply
```

To destroy:

```bash
terraform destroy
```

## Notes / safety

- These lessons create real AWS resources and may incur costs.
- Prefer running `terraform destroy` when you’re done.
