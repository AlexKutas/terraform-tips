provider "aws" {
    region = "eu-central-1" # Frankfurt
}

resource "aws_instance" "webserver" {
    ami                    = "ami-014f11e8c26ed3e15" # Amazon Linux 2023
    instance_type          = "t3.micro"
    vpc_security_group_ids = [aws_security_group.webserver_sg.id]
    user_data              = templatefile("scripts/install_web_server.sh.tpl", {
        f_name = "Terraform",
        l_name = "HashiCorp",
        names  = ["Consul", "Vault", "Nomand", "Packer"]
    })

    tags = {
        Name = "webserver"
    }

}
resource "aws_security_group" "webserver_sg" {
    name        = "webserver_sg"
    description = "Security group for webserver"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "webserver_sg"
    }
}