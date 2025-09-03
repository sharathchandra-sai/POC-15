provider "aws" {
  region = ap-southeast-1
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0933f1385008d33c4"
  instance_type = "t2.medium"
  tags = {
    Name = "JenkinsServer"
  }
}
