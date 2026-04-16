provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      Owner       = var.env == "prod" ? var.prod_owner : var.no_prod_owner
      Environment = var.env
    }
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.env == "prod" ? var.ec2_size_by_env["prod"] : "t2.micro"

  tags = {
    Name        = "${var.env}-server"
  }
}

resource "aws_instance" "server_map" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.ec2_size_by_env, var.env, "t2.micro")

  tags = {
    Name        = "${var.env}-server"
  }
}

resource "aws_instance" "dev_bastion_host" {
  count         = var.env == "dev" ? 1 : 0
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name        = "Bastion Server for Dev-server"
  }
}

resource "aws_security_group" "dynamic_sg" {
    name = "dynamic_sg"
    description = "Dynamic Security Group"

    dynamic "ingress" {
        for_each = lookup(var.allow_ports_list_by_env, var.env, var.allow_ports_list_by_env["prod"])
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name        = "dynamic_sg"
    }
}