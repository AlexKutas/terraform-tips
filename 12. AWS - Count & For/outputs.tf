output "user_names" {
  value = aws_iam_user.user[*].name
}

output "user_arns" {
  value = [
    for user in aws_iam_user.user :
    "${user.name} has the ARN ${user.arn}"
  ]
}

output "user_names_and_arns" {
  value = {
    for user in aws_iam_user.user :
    user.name => user.arn
  }
}

output "user_has_5_characters_or_more" {
  value = [
    for user in aws_iam_user.user :
    "${user.name} has 3 characters or more" if length(user.name) >= 5
  ]
}

output "servers_ips" {
  value = aws_instance.servers[*].public_ip
}

output "server_map_ips" {
  value = {
    for server in aws_instance.servers :
    server.tags.Name => server.public_ip
  }
}