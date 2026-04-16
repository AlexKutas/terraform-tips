# 7. AWS - Green & Blue

This example provisions a small highly-available web stack: VPC + public subnets, an Application Load Balancer (ALB), a Launch Template, and an Auto Scaling Group (ASG). It’s a good base for “blue/green”-style iterations (new LT/ASG revisions behind the ALB).

## What it creates

- **Networking**
  - `aws_vpc.main`
  - `aws_internet_gateway.igw`
  - `aws_route_table.public` + associations
  - `aws_subnet.public_1`, `aws_subnet.public_2` (public subnets)
- **Security**
  - `aws_security_group.alb_sg` (HTTP :80 from the Internet)
  - `aws_security_group.ec2_sg` (HTTP :80 only from the ALB SG, plus SSH :22)
- **Compute**
  - `aws_launch_template.web` (Amazon Linux 2023 AMI via data source)
    - bootstraps Apache with `scripts/user_data.sh`
  - `aws_autoscaling_group.asg` (desired/min/max = 2)
- **Load Balancing**
  - `aws_lb.alb`
  - `aws_lb_target_group.tg`
  - `aws_lb_listener.listener`

Output:

- `alb_dns` (ALB DNS name)

Region: `eu-central-1` (Frankfurt).

## How to run

```bash
terraform init
terraform apply
```

After apply, open the ALB URL using the `alb_dns` output.

## Notes

- The launch template uses `create_before_destroy` to avoid downtime on replacements.
