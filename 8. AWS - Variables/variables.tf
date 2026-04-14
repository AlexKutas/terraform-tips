variable "region" {
  description = "AWS Region for deploy"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}

variable "enable_detailed_monitoring" {
  description = "Enablr monitoring for instance"
  type        = bool
  default     = false
}

variable "allow_ports" {
  description = "List of ports to open for server"
  type        = list
  default     = [22, 53, 80, 443]
}

variable "common_tag" {
  description = "Common Tags"
  type        = map
  default     = {
      Project     = "Terraform"
      Environment = "Local"
    }
}