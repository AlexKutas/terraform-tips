provider "aws" {
  region = "eu-central-1"
}

locals {
  path_to_logs_file = "${path.cwd}/terraform.logs"
}

resource "null_resource" "get_start_time_playbook" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
   command     = "echo Terrafom Start: $(date) | tee -a \"${local.path_to_logs_file}\""
   interpreter = ["bash", "-c"]
  }
}

resource "null_resource" "get_exec_user" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command     = "echo Exec User: $(whoami) | tee -a \"${local.path_to_logs_file}\""
    interpreter = ["bash", "-c"]
  }

  depends_on = [ null_resource.get_start_time_playbook  ]
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "empty_server" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"

  provisioner "local-exec" {
    command     = "echo Instance: ${aws_instance.empty_server.id} with OS: ${data.aws_ami.latest_amazon_linux.name} create! | tee -a \"${local.path_to_logs_file}\""
    interpreter = [ "bash", "-c" ]
  }
}

resource "null_resource" "get_finish_time_playbook" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
   command     ="echo Terrafom Finish: $(date) | tee -a \"${local.path_to_logs_file}\""
   interpreter = ["bash", "-c"]
  }

  depends_on = [ aws_instance.empty_server ]
}