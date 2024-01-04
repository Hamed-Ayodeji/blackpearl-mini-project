output "project-name" {
  value = var.project-name
}

output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "subnet-ids" {
  value = values(aws_subnet.subnets)[*].id
}
