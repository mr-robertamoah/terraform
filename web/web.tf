terraform {
  required_providers {
    aws = {
      version = "~> 5.63.1"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"
  name   = "test"
}

resource "aws_instance" "ec_public" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true

  tags = {
    Name = "${module.vpc.name}-public-instance-1"
  }

  subnet_id       = module.vpc.public_subnet_ids[count.index]
  user_data       = file("files/init-public.sh")
  security_groups = ["${aws_security_group.ec_public.id}"]
  count           = length(module.vpc.public_subnet_ids)
}

resource "aws_instance" "ec_private" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${module.vpc.name}-private-instance-1"
  }

  subnet_id       = module.vpc.private_subnet_ids[count.index]
  user_data       = file("files/init-private.sh")
  security_groups = ["${aws_security_group.ec_private.id}"]
  count           = length(module.vpc.private_subnet_ids)
}

resource "aws_security_group" "ec_public" {
  vpc_id = module.vpc.vpc_id

  egress {
    protocol    = "-1"
    to_port = 0
    from_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["13.48.4.200/30"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    to_port     = 443
    from_port   = 443
  }
}

resource "aws_security_group" "ec_private" {
  vpc_id = module.vpc.vpc_id

  egress {
    protocol    = "-1"
    to_port = 0
    from_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    cidr_blocks = ["13.48.4.200/30"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
}