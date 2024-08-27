variable "region" {
  description = "This is the region within which all the resources will be managed."
  default = "eu-north-1"
}

variable "vpc_cidr" {
  description = "This is the CIDR block of the VPC."
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Enabling DNS support on VPC."
  default = true
}

variable "enable_dns_support" {
  description = "Enabling DNS support on VPC."
  default = true
}

variable "subnet_cidr" {
  description = "This is the CIDR block of the VPC subnets."
  default = "10.0.0.0/24"
}

variable "vpc_tags" {
  description = "Tags for the VPC."
  default = {
    key = "Name"
    value = "test"
  }
  type = map(string)
}