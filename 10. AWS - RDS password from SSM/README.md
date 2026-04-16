# 10. AWS - RDS password from SSM

This example shows how to **generate a random password in Terraform**, store it in **AWS Systems Manager Parameter Store** as a **SecureString**, read it back with a **data source**, and use it as the **RDS MySQL master password**—without hard-coding secrets in `.tf` files.

## What it creates / uses

- **`random_string.rds_password`**: 12-character password with special characters (with `keepers` so you can control when it rotates).
- **`aws_ssm_parameter.rds_password`**: parameter `/prod/mysql`, type `SecureString`, value = generated password.
- **`data.aws_ssm_parameter.rds_password`**: reads the same parameter (with `depends_on` so it runs after the parameter exists).
- **`aws_db_instance.default`**: MySQL 8.0 RDS (`db.t3.micro`, 10 GB `gp2`, encrypted, `skip_final_snapshot = true`).

## Outputs

- **`rds_password`**: the password value (marked `sensitive` in Terraform).

Region: `eu-central-1`.

## Providers

This configuration uses the **`random`** provider in addition to **`aws`**. Run `terraform init` once so Terraform downloads both providers.

## How to run

```bash
cd "10. AWS - RDS password from SSM"
terraform init
terraform plan
terraform apply
```

## How to destroy

```bash
terraform destroy
```

Destroy removes the RDS instance, the SSM parameter, and stops managing the random password (a new apply would generate a new value).

## Notes / safety

- **RDS + SSM cost money** in AWS; use `terraform destroy` when you are done.
- The password is still visible in **Terraform state** and in **plan/apply output** if not handled carefully—treat state files as secret and use remote state with encryption and tight access if you use this pattern in production.
- Typo in resource: identifier is `prod-terrafrom-db` (as in code).
