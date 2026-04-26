# ------------------------------------------------------------
# Terraform configuration for AWS WebServer
# ------------------------------------------------------------

# Provider
provider "aws" {
    region = "eu-central-1" # Frankfurt
}

resource "aws_eip" "webserver_static_ip" {
    instance = aws_instance.webserver.id
}

resource "aws_instance" "webserver" {
    ami = "ami-014f11e8c26ed3e15" # Amazon Linux 2023
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.webserver_dynamic_sg.id]
    user_data = templatefile("scripts/install_web_server.sh.tpl", {
        f_name = "Terraform",
        l_name = "HashiCorp",
        names = ["Consul", "Vault", "Nomand", "Packer", "Waypoint", "Boundary", "Vault Radar"]
    })

    tags = {
        Name = "webserver"
    }

    # lifecycle {
    #   prevent_destroy = true
    #   ignore_changes = [ ami, user_data ]
    # }

    lifecycle {
      create_before_destroy = true
      ignore_changes = [ ami, user_data ]
    }

}


resource "aws_security_group" "webserver_dynamic_sg" {
    name = "webserver_dynamic_sg"
    description = "WebServer Dynamic Security Group"

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
        Name = "webserver_dynamic_sg"
    }
}