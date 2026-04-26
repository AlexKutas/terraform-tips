# 04. AWS - Life Cycle & Output

This example demonstrates Terraform `lifecycle` behavior (e.g. `create_before_destroy`, `ignore_changes`) and using `output` values.

## What it creates

- `aws_instance.webserver` (Amazon Linux 2023, `t3.micro`)
  - `user_data` rendered from `scripts/install_web_server.sh.tpl`
  - `lifecycle`:
    - `create_before_destroy = true`
    - `ignore_changes = [ami, user_data]`
- `aws_security_group.webserver_dynamic_sg`
  - Dynamic ingress ports: `25, 53, 80, 443, 465, 993`
  - SSH `22` from `10.10.0.0/16`
- `aws_eip.webserver_static_ip` attached to the instance

Outputs:

- `webserver_public_ip`
- `webserver_security_group_id`

Region: `eu-central-1` (Frankfurt).

## How to run

```bash
terraform init
terraform apply
```

## Notes

- Because of `ignore_changes`, modifying `ami` or `user_data` in the config will not trigger updates for the instance.
