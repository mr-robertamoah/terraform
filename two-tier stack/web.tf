terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.63.1"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source      = "./vpc"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.0.0/24"
  vpc_tags = {
    key   = "Name"
    value = "test-vpc"
  }
}

resource "aws_elb" "load_balancer" {
  subnets = ["${module.vpc.public_subnet_id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  security_groups = ["${aws_security_group.web_inbound.id}"]
  instances       = aws_instance.web[*].id
}

resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web_host.id]
  private_ip             = var.ec2_ips[count.index]
  count                  = length(var.ec2_ips)
  user_data              = file("files/bootstrap.sh")
}

resource "aws_security_group" "web_host" {
  name        = "web_host"
  description = "Allow SSH & HTTP to web hosts"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_inbound" {
  name        = "web_inbound"
  description = "Allow HTTP from Anywhere"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}