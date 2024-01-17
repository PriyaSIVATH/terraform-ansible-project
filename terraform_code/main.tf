terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-east-1" 
    access_key = var.access_key_value
    secret_key = var.secret_key_value
}

resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
    key_name = var.key_name
    public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
    content = tls_private_key.rsa_4096.private_key_pem
    filename = var.key_name
}

resource "aws_instance" "target-server" {
    ami = var.ami_value
    instance_type = var.instance_type_value
    key_name = aws_key_pair.key_pair.key_name

    tags = {
      Name = var.tag_name
    }
}

resource "aws_security_group" "terraform_sg" {
  name        = "Security group using Terraform"
  description = "Security group using Terraform"
  vpc_id      = var.vpc_id_value


 ingress {
    description	     = "HTTP"
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}

ingress {
    description	     = "SSH"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
    Name = "tf_securitygroup"
  }
}

