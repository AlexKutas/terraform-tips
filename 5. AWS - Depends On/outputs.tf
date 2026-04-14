# ------------------------------------------------------------
# Terraform outputs for AWS WebServer
# ------------------------------------------------------------

output "webserver_public_ip" {
  value = aws_eip.webserver_static_ip.public_ip
  description = "Web Server public IP"
}

output "application_private_ip" {
  value = aws_instance.application.private_ip
  description = "Application private IP"
}

output "database_private_ip" {
  value = aws_instance.database.private_ip
  description = "Database private IP"
}