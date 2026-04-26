output "webserver_public_ip" {
  value       = aws_eip.webserver_static_ip.public_ip
  description = "Web Server public IP"
}

output "webserver_security_group_id" {
  value       = aws_security_group.webserver_dynamic_sg.id
  description = "Web Server Security Group ID"
}