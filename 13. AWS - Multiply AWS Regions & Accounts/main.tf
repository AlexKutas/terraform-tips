locals {
  environment = {
    primary = {
      region = "eu-central-1"
      human_name = "Frankfurt"
    }
    n_virginia = {
      region = "us-east-1"
      human_name = "Virginia"
    }
  }
}

provider "aws" {
  region = local.environment.primary.region
  alias  = "primary"

  # ⚠️ Do NOT hardcode AWS credentials in Terraform code.
  # This is insecure and may expose secrets in version control.
  #
  # Even when using multiple AWS providers, credentials should be
  # provided via environment variables or AWS profiles:
  #   AWS_ACCESS_KEY_ID
  #   AWS_SECRET_ACCESS_KEY
  #
  # For multi-account setups, prefer using assume_role with a single
  # set of base credentials.
  #
  # The values below are fake and for demonstration purposes only.
  access_key = "AKIAQ2Q2Q2Q2Q2Q2Q2Q2Q"
  secret_key = "Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2Q2"
  
  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/terraform-role"
  }
}

provider "aws" {
  region = local.environment.n_virginia.region
  alias  = "n_virginia"
}

data "aws_ami" "latest_amazon_linux_primary" {
  provider    = aws.primary
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_amazon_linux_n_virginia" {
  provider    = aws.n_virginia
  owners      = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}


resource "aws_instance" "server_primary" {
  provider      = aws.primary
  ami           = data.aws_ami.latest_amazon_linux_primary.id
  instance_type = "t3.micro"
  tags = {
    Name = "Server in ${local.environment.primary.human_name}"
  }
}

resource "aws_instance" "server_n_virginia" {
  provider      = aws.n_virginia
  ami           = data.aws_ami.latest_amazon_linux_n_virginia.id
  instance_type = "t3.micro"
  tags = {
    Name = "Server in ${local.environment.n_virginia.human_name}"
  }
}