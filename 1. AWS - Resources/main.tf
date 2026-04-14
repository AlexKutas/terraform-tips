provider "aws" {
    region = "eu-central-1" # Frankfurt
}

resource "aws_instance" "terraform-test" {
    ami = "ami-05852c5f195d545ea" # Ubuntu 24.04 LTS
    instance_type = "t3.micro"
    tags = {
        Name = "terraform-test"
    }
}