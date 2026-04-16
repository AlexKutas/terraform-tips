# 9. AWS - Exec Local

This example demonstrates Terraform provisioners with `local-exec` and `null_resource` to run local shell commands during `apply`, and log execution details to a file.

## What it does

- Writes a log file to `terraform.logs` in the current working directory (`${path.cwd}`)
- Logs:
  - start time
  - the local OS user running Terraform (`whoami`)
  - the created instance id and selected AMI name
  - finish time

## What it creates

- `null_resource.get_start_time_playbook` (runs on every apply via `timestamp()` trigger)
- `null_resource.get_exec_user` (depends on start)
- `aws_instance.empty_server` (Amazon Linux AMI via data source)
  - runs a `local-exec` message after creation
- `null_resource.get_finish_time_playbook` (depends on instance)

Region: `eu-central-1` (Frankfurt).

## How to run

```bash
terraform init
terraform apply
```

After apply, check `terraform.logs` in this folder.

## Notes

- `null_resource` + `local-exec` are useful for demos and glue, but for serious workflows prefer CI/CD steps or dedicated tooling when possible.
