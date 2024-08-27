output "public_instance_ids" {
  value = aws_instance.ec_public.*.id
}

output "public_instance_public_ips" {
  value = aws_instance.ec_public.*.public_ip
}

output "public_instance_private_ips" {
  value = aws_instance.ec_public.*.private_ip
}

output "private_instance_ids" {
  value = aws_instance.ec_private.*.id
}

output "private_instance_private_ips" {
  value = aws_instance.ec_private.*.private_ip
}