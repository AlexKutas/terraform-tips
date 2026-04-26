resource "aws_instance" "sever_amazon" {
  ami = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"
}