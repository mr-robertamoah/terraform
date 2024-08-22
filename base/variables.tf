variable "region" {
  default     = "eu-north-1"
  description = "The region in which to launch resources."
}

variable "ami" {
  default     = "ami-04cdc91e49cb06165"
  description = "The ubuntu AMI to use in the region."
}

variable "instance_type" {
  default     = "t3.micro"
  description = "The instance type of the EC2 resources."
}

variable "ec2_tags" {
  default = {
    name  = "Name"
    value = "test-terraform"
  }

  description = "Key-value pair for the tags of EC2 instance"
  type        = map(string)
}