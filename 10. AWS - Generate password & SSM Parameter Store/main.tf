provider "aws" {
  region = "eu-central-1"
}

resource "random_string" "rds_password" {
	length           = 12
	special          = true
	override_special = "/@\""
  keepers = {
    "version" = "v2"
  }
}

resource "aws_ssm_parameter" "rds_password" {
	name        = "/prod/mysql"
	type        = "SecureString"
	description = "Master Password for RDS MySQL"
	value       = random_string.rds_password.result
}

data "aws_ssm_parameter" "rds_password" {
  name       = "/prod/mysql"
  depends_on = [aws_ssm_parameter.rds_password]
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  apply_immediately    = true
  db_name              = "terraform"
  engine               = "mysql"
  engine_version       = "8.0"
  identifier           = "prod-terrafrom-db"
  instance_class       = "db.t3.micro"
  username             = "root"
  password             = data.aws_ssm_parameter.rds_password.value
  parameter_group_name = "default.mysql8.0"
  storage_encrypted    = true
  storage_type         = "gp2"
  skip_final_snapshot  = true
}

output "rds_password" {
  value = data.aws_ssm_parameter.rds_password.value
  sensitive = true
}