# ------------------------------------------------------------
# Terraform outputs for AWS WebServer
# ------------------------------------------------------------

output "names_aws_availability_zones" {
  value = data.aws_availability_zones.availability_zones.names
}

output "current_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "current_aws_region_name" {
  value = data.aws_region.current.region
}

output "curent_aws_region_description" {
  value = data.aws_region.current.description
}

output "all_aws_vpcs" {
  value = data.aws_vpcs.all_vpcs.ids
}

# output "current_aws_vpc" {
#   value = data.aws_vpc.current_aws_vpc.id
# }

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}


output "latest_amazon__linux_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "latest_amazon_linux_ami_name" {
  value = data.aws_ami.latest_amazon_linux.name
}