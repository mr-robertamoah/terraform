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
  region = "eu-north-1"
}

# create an EC2 instance
resource "aws_instance" "base" {
  ami           = "ami-04cdc91e49cb06165"
  instance_type = "t3.micro"

  tags = {
    "name" = "test-terraform"
  }
}

# create an elastic api
resource "aws_eip" "base" {
  instance = aws_instance.base.id
}