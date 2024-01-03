output "elb-arn" {
  value = aws_lb.elb.arn
}

output "elb-dns-name" {
  value = aws_lb.elb.dns_name
}