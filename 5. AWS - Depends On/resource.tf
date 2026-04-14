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

    tags = {
        Name = "webserver"
    }
    
    depends_on = [ aws_instance.application ]

}

resource "aws_instance" "application" {
    ami = "ami-014f11e8c26ed3e15" # Amazon Linux 2023
    instance_type = "t3.micro"

    tags = {
        Name = "application"
    }

    depends_on = [ aws_instance.database ]

}

resource "aws_instance" "database" {
    ami = "ami-014f11e8c26ed3e15" # Amazon Linux 2023
    instance_type = "t3.micro"

    tags = {
        Name = "database"
    }

}

resource "aws_security_group" "webserver_dynamic_sg" {
    name = "webserver_dynamic_sg"
    description = "WebServer Dynamic Security Group"

    dynamic "ingress" {
        for_each = [22, 80, 443]
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
        Name = "webserver_dynamic_sg"
    }
}