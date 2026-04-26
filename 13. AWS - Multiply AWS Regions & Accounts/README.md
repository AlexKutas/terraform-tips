# 13. AWS - Multiply AWS Regions & Accounts

This example shows how to use **more than one `provider "aws"` block** with **`alias`**, different **`region`** values, and the **`provider = aws.<alias>`** meta-argument on **data sources** and **resources** so Terraform can read AMIs and create EC2 instances in **two regions** in one configuration.

## What it uses / creates

- **`locals.environment`**: maps logical names (**`primary`**, **`n_virginia`**) to **`region`** and a **`human_name`** label used in instance tags.
- **`provider "aws"` with `alias = "primary"`**: **`eu-central-1`**. Includes an **`assume_role`** block (demo **`role_arn`**) and **placeholder** `access_key` / `secret_key` in code—see **Notes / safety** below.
- **`provider "aws"` with `alias = "n_virginia"`**: **`us-east-1`** (no extra auth block in the sample).
- **`data.aws_ami.latest_amazon_linux_primary`**: Amazon Linux 2 HVM GP2 AMI in the primary region (`provider = aws.primary`).
- **`data.aws_ami.latest_amazon_linux_n_virginia`**: Amazon Linux 2023 x86_64 AMI in N. Virginia (`provider = aws.n_virginia`).
- **`aws_instance.server_primary`** / **`aws_instance.server_n_virginia`**: **`t3.micro`** instances, each tied to the matching provider and AMI.

There is **no default (unaliased) AWS provider** in this file: every AWS data source and resource must set **`provider`**.

## How to run

1. **Edit `main.tf` for real credentials** (see notes): remove fake keys, use environment variables or a shared credentials file / profile, and set a real **`assume_role.role_arn`** (or drop **`assume_role`** if you only need one account and one role is not required).
2. From the repo root:

```bash
cd "13. AWS - Multiply AWS Regions & Accounts"
terraform init
terraform plan
terraform apply
```

## How to destroy

```bash
terraform destroy
```

## Notes / safety

- **Do not commit real AWS access keys.** The strings in **`main.tf`** are **fake placeholders** for illustration only; replace them with the usual pattern (for example **`AWS_PROFILE`**, **`AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`**, or **`aws configure`**).
- **`assume_role`** is shown as a pattern for **cross-account** or **least-privilege** access: the principal in your profile/session must be **allowed to assume** that role, and **`role_arn`** must point to a role that exists in your organization.
- **Two EC2 instances** (two regions) **incur cost**; destroy when finished.
- AMI filters differ by region/naming (`amzn2-...` vs `al2023-...`); adjust filters if AWS changes naming or you prefer the same OS in both regions.
