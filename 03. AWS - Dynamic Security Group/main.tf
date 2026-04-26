# ------------------------------------------------------------
# Terraform configuration for AWS WebServer
# ------------------------------------------------------------

# Provider
provider "aws" {
    region = "eu-central-1" # Frankfurt
}

resource "aws_security_group" "dynamic_sg" {
    name = "dynamic_sg"
    description = "Dynamic Security Group"

    dynamic "ingress" {
        for_each = [25, 53, 80, 443, 465, 993]
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.10.0.0/16"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "dynamic_sg"
    }
}