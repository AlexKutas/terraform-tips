# 08. AWS - Variables

This example demonstrates Terraform input variables, locals, maps, and per-environment values using `*.auto.tfvars`.

## What it creates

- `aws_default_vpc.default_vpc` (references the account default VPC)
- `aws_security_group.security_group`
  - ingress ports are generated from `var.allow_ports` via a `dynamic "ingress"` block
- `aws_instance.server`
  - AMI is resolved via data source `data.aws_ami.latest_amazon_linux`
  - instance type from `var.instance_type`
  - detailed monitoring from `var.enable_detailed_monitoring`
- `aws_eip.static_ip` attached to the instance

Outputs:

- `static_ip`
- `instance_id`
- `security_group_id`

## Variables / files

- `variables.tf`: defines `region`, `instance_type`, `enable_detailed_monitoring`, `allow_ports`, `common_tag`
- `main.tf`: uses `locals.project_name` and merges tags
- `dev.auto.tfvars`: development values
- `prod.auto.tfvars`: production values

## How to run

Terraform automatically loads `*.auto.tfvars` in the working directory.

- **Development**

```bash
terraform init
terraform apply
```

- **Production**

Temporarily rename files (or move one out) so only the desired `*.auto.tfvars` is picked up, then run:

```bash
terraform apply
```

## Notes

- If both `dev.auto.tfvars` and `prod.auto.tfvars` exist at the same time, Terraform will load both; avoid that unless you know exactly how conflicts should resolve.
