output "exported_ips" {
  value = local.host-ips
}

output "instance_ids" {
  value = aws_instance.ec2.*.id
}