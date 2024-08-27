# Managing a Two-tier Infrastructure on AWS

This configuration creates two EC2 instances and a load balance which targets the instances and forwards traffic on port 80 to the instances.
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