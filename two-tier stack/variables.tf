variable "region" {
  description = "This is the region within which all the resources will be managed."
  default     = "eu-north-1"
}

variable "ami" {
  default     = "ami-04cdc91e49cb06165"
  description = "The ubuntu AMI to use in the region."
}

variable "instance_type" {
  default     = "t3.micro"
  description = "The instance type of the EC2 resources."
}

variable "ec2_ips" {
  description = "This is the region within which all the resources will be managed."
  default     = ["10.0.0.20", "10.0.0.21"]
}