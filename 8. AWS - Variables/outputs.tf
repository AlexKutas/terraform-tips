output "static_ip" {
  value = aws_eip.static_ip.public_ip
}

output "instance_id" {
  value = aws_instance.server.id
}

output "security_group_id" {
  value = aws_security_group.security_group.id
}
