resource "aws_instance" "jenkins" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = file("${path.module}/install_jenkins.sh")

  tags = {
    Name = "Jenkins-Server"
  }

}