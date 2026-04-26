provider "aws" {
  region = var.region
}

locals {
  project_name = "${var.common_tag["Project"]}-${var.common_tag["Environment"]}"
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_default_vpc" "default_vpc" {}

resource "aws_security_group" "security_group" {
  name   = "Secutiry Group"
  vpc_id = aws_default_vpc.default_vpc.id
  dynamic "ingress" {
    for_each = var.allow_ports
    content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tag, {
    Name              = "Security Group"
    Full_Project_Name = local.project_name
  })

}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]
  monitoring             = var.enable_detailed_monitoring

  tags = merge(var.common_tag, {
    Name              = "Instance"
    Full_Project_Name = local.project_name
  })
}

resource "aws_eip" "static_ip" {
  instance = aws_instance.server.id

  tags = merge(var.common_tag, {
    Name              = "Static IP"
    Full_Project_Name = local.project_name
  })
}
