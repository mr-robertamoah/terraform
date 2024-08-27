# Managing a Multple Instances Infrastructure on AWS

This configuration creates a VPC with a given number of private and public subnets depending on the specified public_subnet_count and private_subnet_count of the vpc module. EC2 instances are created in each subnet (both public and private) with associated security groups.
---

## Usage

```bash
$ aws configure # run this if you have not configured aws credentials
$ terraform get
$ terraform fmt
$ terraform validate
$ terraform plan
$ terraform apply
$ terraform destroy
```