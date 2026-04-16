
variable "env" {
  default = "prod"
  type = string
}

variable "prod_owner" {
  default = "John Jimson"
}

variable "no_prod_owner" {
  default = "Tom Toff"
}

variable "ec2_size_by_env" {
  default = {
    "prod"    = "t3.medium"
    "dev"     = "t3.micro"
    "staging" = "t3.small"
  }
}

variable "allow_ports_list_by_env" {
  default = {
    "prod"    = ["80", "443"]
    "dev"     = ["22", "80", "443", "3000", "8000"]
    "staging" = ["22", "80", "443"]
  }
}