variable "region" {
  default     = "eu-north-1"
  description = "This is the region within which to provision resources."
}

variable "name" {
  description = "This is the name of the VPC to create."
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  description = "This is the CIDR block of the VPC."
}

variable "public_subnet_count" {
  default     = 1
  description = "This sets the number of public subnets to create in the VPC."
}

variable "private_subnet_count" {
  default     = 1
  description = "This sets the number of private subnets to create in the VPC."
}

variable "subnet_cidr_block" {
  default     = "10.0.0.0/24"
  description = "This is the CIDR block of the VPC."
}

variable "enable_dns_hostnames" {
  default     = true
  description = "This enables DNS support on the VPC."
}

variable "enable_dns_support" {
  default     = true
  description = "This enables DNS support on the VPC."
}