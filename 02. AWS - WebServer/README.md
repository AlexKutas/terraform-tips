# 02. AWS - WebServer

This example provisions an EC2-based web server and a Security Group, and bootstraps Apache via `user_data` rendered from a template.

## What it creates

- `aws_security_group.webserver_sg` (ingress: 80/443/22 from `0.0.0.0/0`)
- `aws_instance.webserver` (Amazon Linux 2023, `t3.micro`)
  - `user_data` comes from `scripts/install_web_server.sh.tpl` via `templatefile()`

Region: `eu-central-1` (Frankfurt).

## How to run

```bash
terraform init
terraform plan
terraform apply
```

## Notes

- The `user_data` template uses variables (`f_name`, `l_name`, `names`) to generate `/var/www/html/index.html`.
