provider "aws" {
  region = var.region
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
    Name = "JenkinsServer"
  }
}
