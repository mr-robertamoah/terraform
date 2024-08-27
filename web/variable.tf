variable "region" {
  default     = "eu-north-1"
  description = "This is the region within which to provision resources."
}

variable "ami" {
  default     = "ami-04cdc91e49cb06165"
  description = "Amazon machine instance."
}

variable "instance_type" {
  default     = "t3.micro"
  description = "EC2 instance type."
}