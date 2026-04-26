# 06. AWS - Data Source

This example demonstrates Terraform **data sources** (querying AWS for information) alongside provisioning a small VPC + subnets.

## What it uses (data sources)

- `data.aws_availability_zones.availability_zones`
- `data.aws_caller_identity.current`
- `data.aws_region.current`
- `data.aws_vpcs.all_vpcs`
- `data.aws_ami.latest_ubuntu` (Ubuntu 24.04 “noble”)
- `data.aws_ami.latest_amazon_linux` (Amazon Linux 2023)

## What it creates (resources)

- `aws_vpc.production_vpc` (`10.10.0.0/22`)
- `aws_subnet.production_subnet_1/2/3` in different AZs
- `aws_instance.sever_amazon` (EC2 with the latest Amazon Linux AMI)

## Outputs

This module outputs availability zones, account id, region details, all VPC ids, and AMI ids/names for Ubuntu and Amazon Linux.

## How to run

```bash
terraform init
terraform plan
terraform apply
```

## Notes

- Data sources are evaluated during plan/apply and let you avoid hard-coding IDs (like AMI IDs or AZ names).
