provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_user" "user" {
  count = length(var.user_names)
  name  = element(var.user_names, count.index)
}

resource "aws_instance" "servers" {
  count = length(var.user_names)
  ami = "ami-014f11e8c26ed3e15"
  instance_type = "t3.micro"
  tags = {
    Name = "Server ${count.index + 1}"
  }
}