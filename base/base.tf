# set up provider version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.63.1"
    }
  }
}

# connecting to AWS
provider "aws" {
  region = var.region
}

# create an EC2 instance
resource "aws_instance" "base" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    "${var.ec2_tags["name"]}" = "${var.ec2_tags["value"]}"
  }
}

# create an elastic api
resource "aws_eip" "base" {
  instance = aws_instance.base.id
}