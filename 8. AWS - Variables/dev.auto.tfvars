region                     = "eu-central-1"
instance_type              = "t3.micro"
enable_detailed_monitoring = true
allow_ports                = [22, 53, 80, 443, 3000, 8080]
common_tag                 = {
  Project     = "Terraform"
  Environment = "Development"
}