region                     = "eu-central-1"
instance_type              = "t3.small"
enable_detailed_monitoring = true
allow_ports                = [80, 443]
common_tag                 = {
  Project     = "Terraform"
  Environment = "Production"
}