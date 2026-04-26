# Terraform AWS Examples

A collection of small Terraform examples for AWS. Each numbered folder is standalone with its own `main.tf` (and sometimes `variables.tf`, `outputs.tf`, templates, or scripts).

## Prerequisites

- Terraform installed (`terraform -version`)
- An AWS account + credentials configured (for example via environment variables or an AWS profile)
- Permissions to create resources like EC2, VPC, Security Groups, ALB, ASG, EIP, RDS, SSM Parameter Store

## Repository structure

- `01. AWS - Resources`: minimal EC2 instance
- `02. AWS - WebServer`: EC2 + Security Group + `user_data` from a template
- `03. AWS - Dynamic Security Group`: `dynamic` ingress rules in a Security Group
- `04. AWS - Life Cicle & Output`: `lifecycle` settings + outputs + EIP
- `05. AWS - Depends On`: explicit resource ordering via `depends_on`
- `06. AWS - Data Source`: data sources (AMIs/AZs/account/region/VPCs) + sample VPC/subnets
- `07. AWS - Green & Blue Deploy`: ALB + Launch Template + Auto Scaling Group in a VPC (base for blue/green-style deploys)
- `08. AWS - Variables`: variables, locals, tags merging, and `.auto.tfvars` environments
- `09. AWS - Exec Local`: `null_resource` + `local-exec` logging during apply
- `10. AWS - RDS password from SSM`: `random` password → SSM `SecureString` → RDS MySQL uses it via data source
- `11. AWS - Conditions & Lookups`: `env`-based ternary / `lookup()` / `count` / `dynamic` ingress + provider `default_tags`
- `12. AWS - Count & For`: `count` from a list; splat `[*]` and `for` expressions in outputs (IAM users + EC2)
- `13. AWS - Multiply AWS Regions & Accounts`: multiple `provider "aws"` aliases (`eu-central-1` + `us-east-1`), `provider =` on resources/data; optional `assume_role` (edit before real use)

Each folder also contains its own `README.md` with details.

## How to run any example

From the repo root:

```bash
cd "01. AWS - Resources"   # or any other folder name from the list above (01–09 use a leading zero)
terraform init
terraform plan
terraform apply
```

To destroy:

```bash
terraform destroy
```

## Notes / safety

- These examples create real AWS resources and may incur costs.
- Prefer running `terraform destroy` when you’re done.
