data "aws_availability_zones" "availability_zones" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "all_vpcs" {}

# data "aws_vpc" "current_aws_vpc" {
#     tags = {
#       Name = "production_vpc"
#     }
# }

resource "aws_vpc" "production_vpc" {
    cidr_block = "10.10.0.0/22"

    tags = {
      Name = "production_vpc"
    }
}

resource "aws_subnet" "production_subnet_1" {
  vpc_id            = aws_vpc.production_vpc.id
  availability_zone = data.aws_availability_zones.availability_zones.names[0]
  cidr_block        = "10.10.1.0/24"
  tags              = {
    Name    = "production_subnet_1"
    Account = "${data.aws_caller_identity.current.account_id}"
    Region  = "${data.aws_availability_zones.availability_zones.names[0]}"
  }
}

resource "aws_subnet" "production_subnet_2" {
  vpc_id            = aws_vpc.production_vpc.id
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
  cidr_block        = "10.10.2.0/24"
  tags              = {
    Name    = "production_subnet_2"
    Account = "${data.aws_caller_identity.current.account_id}"
    Region  = "${data.aws_availability_zones.availability_zones.names[1]}"
  }
}

resource "aws_subnet" "production_subnet_3" {
  vpc_id            = aws_vpc.production_vpc.id
  availability_zone = data.aws_availability_zones.availability_zones.names[2]
  cidr_block        = "10.10.3.0/24"
  tags              = {
    Name    = "production_subnet_3"
    Account = "${data.aws_caller_identity.current.account_id}"
    Region  = "${data.aws_availability_zones.availability_zones.names[2]}"
  }
}
