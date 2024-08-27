output "elb_address" {
  value = aws_elb.load_balancer.dns_name
}

output "instance_ids" {
  value = aws_instance.web.*.public_ip
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}