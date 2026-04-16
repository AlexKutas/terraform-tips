# 7. AWS - Green & Blue Deploy

This example provisions a small highly-available web stack: VPC + public subnets, an **Application Load Balancer (ALB)**, a **Launch Template**, and an **Auto Scaling Group (ASG)**. That setup is a common base for **green/blue deployment**: you keep traffic on the ALB, publish new AMI or launch-template versions (a new “color”), register instances to the same target group or swap listeners, and cut over with minimal downtime. This folder shows the **single-stack baseline** (one ASG + one LT)—the infrastructure pattern you extend with a second stack for full blue/green.

## What it creates

- **Networking**
  - `aws_vpc.main`
  - `aws_internet_gateway.igw`
  - `aws_route_table.public` + associations
  - `aws_subnet.public_1`, `aws_subnet.public_2` (public subnets, two AZs)
- **Security**
  - `aws_security_group.alb_sg` (HTTP :80 from the Internet)
  - `aws_security_group.ec2_sg` (HTTP :80 only from the ALB SG, plus SSH :22)
- **Compute**
  - `aws_launch_template.web` (Amazon Linux 2023 AMI via data source)
    - bootstraps Apache with `scripts/user_data.sh`
  - `aws_autoscaling_group.asg` (desired/min/max = 2) — instances sit behind the ALB; for **green/blue** you would typically add another ASG/LT pair and shift traffic between them
- **Load balancing**
  - `aws_lb.alb`
  - `aws_lb_target_group.tg`
  - `aws_lb_listener.listener`

**Green / blue deploy:** In production, “green” and “blue” are two parallel releases; the ALB and target group are where you attach new instances or switch rules. This example does **not** create two colors—it only builds the shared ALB + ASG + LT pattern you need for that workflow.

Output:

- `alb_dns` (ALB DNS name)

Region: `eu-central-1` (Frankfurt).

## How to run

From the repo root:

```bash
cd "7. AWS - Green & Blue Deploy"
terraform init
terraform plan
terraform apply
```

After apply:

```bash
terraform output -raw alb_dns
```

Visit `http://<alb_dns>` — you should see the Apache page (instances may show different IPs as the ALB balances).

## How to destroy

```bash
terraform destroy
```

## Notes

- **`lifecycle { create_before_destroy = true }`** is set on both the launch template and the ASG to reduce disruption when those resources must be replaced.
- **Cost:** VPC networking is cheap; ALB and EC2 hours add up—destroy when finished.
- **SSH:** Port 22 is open to the world on `ec2_sg` for lab convenience; tighten CIDR in real environments.
