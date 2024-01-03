output "project-name" {
  value = var.project-name
}

output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "subnet-ids" {
  value = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id,
    aws_subnet.public-subnet-3.id
  ]
}

output "subnets-cidr-blocks" {
  value = [
    aws_subnet.public-subnet-1.cidr_block,
    aws_subnet.public-subnet-2.cidr_block,
    aws_subnet.public-subnet-3.cidr_block
  ]
}