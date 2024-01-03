output "public-instance-sg-id" {
  value = aws_security_group.public-instance-sg.id
}

output "elb-sg-id" {
  value = aws_security_group.elb-sg.id
}