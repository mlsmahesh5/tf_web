terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "tf_web_sg" {
  name        = "tf_web_sg"
  description = "For terraform web application"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_instance" "Mahesh_web" {
  ami = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.tf_web_sg.name}"]
  user_data = <<-EOF
       #!/bin/bash
       sudo yum install httpd -y
       sudo systemctl start httpd
       sudo systemctl enable httpd
       echo "<h1>Welcome to Msys Technologies Pvt Ltd...<br>Kilari Mahesh</h1>" >> /var/www/html/index.html
 EOF

  tags = {
    Name = "Mahesh_webserver"
  }
}
