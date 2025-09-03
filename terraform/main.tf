provider "aws" {
  region = var.region
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0933f1385008d33c4"
  instance_type = "t3.medium"
  tags = {
    Name = "JenkinsServer"
  }
}
