# 11. AWS - Conditions & Lookups

This example shows how to drive AWS resources from **`var.env`** using **conditional expressions** (`? :`), **`lookup()`** for map defaults, **`count`** for optional resources, and **`dynamic` blocks** fed by per-environment lists.

## What it creates

- **`data.aws_ami.latest_amazon_linux`**: latest Amazon Linux 2 (`amzn2-ami-hvm-*-x86_64-gp2`).
- **`aws_instance.server`**: instance type chosen with a **ternary** — `prod` uses `var.ec2_size_by_env["prod"]`, otherwise `t2.micro`.
- **`aws_instance.server_map`**: same AMI, but instance type from **`lookup(var.ec2_size_by_env, var.env, "t2.micro")`** (demonstrates map lookup + fallback).
- **`aws_instance.dev_bastion_host`**: created only when **`var.env == "dev"`** (`count = 1` or `0`).
- **`aws_security_group.dynamic_sg`**: **`dynamic "ingress"`** with `for_each = lookup(var.allow_ports_list_by_env, var.env, var.allow_ports_list_by_env["prod"])` — open TCP ports per environment, defaulting to prod’s list if `env` is missing from the map.

## Provider default tags

The **`aws`** provider uses **`default_tags`**: `Owner` is **`var.prod_owner`** in prod, otherwise **`var.no_prod_owner`**; `Environment` is **`var.env`**.

## Variables (`variables.tf`)

| Variable | Role |
|----------|------|
| `env` | Environment name (`prod` default). |
| `prod_owner` / `no_prod_owner` | Used in default tags (prod vs non-prod). |
| `ec2_size_by_env` | Map of instance types per env (`prod`, `dev`, `staging`). |
| `allow_ports_list_by_env` | Map of port lists (as strings) per env for the dynamic SG. |

## How to run

```bash
cd "11. AWS - Conditions & Lookups"
terraform init
terraform plan
terraform apply
```

Override `env` without editing files:

```bash
terraform apply -var='env=dev'
```

## How to destroy

```bash
terraform destroy
```

## Notes

- **Security:** ingress uses `0.0.0.0/0` for lab simplicity — tighten in real use.
- **`server` vs `server_map`:** two ways to pick instance size from `env`; in real configs you usually keep one pattern.

Region: `eu-central-1`.
