provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support = "${var.enable_dns_support}"

  tags = {
    "${var.vpc_tags["key"]}" = "${var.vpc_tags["value"]}"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.main.id}"
  
  tags = {
    "${var.vpc_tags["key"]}" = "${var.vpc_tags["value"]}-igw"
  }
}

resource "aws_subnet" "public_subnet_1" {
  cidr_block = "${var.subnet_cidr}"
  vpc_id = "${aws_vpc.main.id}"
  
  tags = {
    "${var.vpc_tags["key"]}" = "${var.vpc_tags["value"]}-public"
  }
}

resource "aws_route" "internet_access" {
  gateway_id = "${aws_internet_gateway.vpc_igw.id}"
  route_table_id = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
}