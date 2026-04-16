# 5. AWS - Depends On

This example demonstrates explicit dependencies in Terraform using `depends_on`, forcing a specific creation order between resources.

## What it creates

- `aws_instance.database`
- `aws_instance.application` (depends on `aws_instance.database`)
- `aws_instance.webserver` (depends on `aws_instance.application`)
- `aws_security_group.webserver_dynamic_sg` (dynamic ingress for `22, 80, 443`)
- `aws_eip.webserver_static_ip` attached to `aws_instance.webserver`

Outputs:

- `webserver_public_ip`
- `application_private_ip`
- `database_private_ip`

Region: `eu-central-1` (Frankfurt).

## How to run

```bash
terraform init
terraform apply
```

## Notes

- In real projects, Terraform usually infers dependencies from references automatically. Use `depends_on` when you need to enforce order even without direct references.
