resource "aws_instance" "jenkins" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = file("${path.module}/install_jenkins.sh")

  tags = {
    Name = "Jenkins-Server"
  }

}

provider "aws" {
  region = "ap-south-1"
}

module "jenkins_server" {

  source        = "./modules/jenkins"
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  key_name      = "terraform-key"

}