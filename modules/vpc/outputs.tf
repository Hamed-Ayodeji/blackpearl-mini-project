output "project-name" {
  value = var.project-name
}

output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "public-subnet-1-id" {
  value = aws_subnet.public-subnet-1.id
}

output "public-subnet-2-id" {
  value = aws_subnet.public-subnet-2.id
}

output "public-subnet-3-id" {
  value = aws_subnet.public-subnet-3.id
}

output "public-subnet-1-cidr-block" {
  value = aws_subnet.public-subnet-1.cidr_block
}

output "public-subnet-2-cidr-block" {
  value = aws_subnet.public-subnet-2.cidr_block
}

output "public-subnet-3-cidr-block" {
  value = aws_subnet.public-subnet-3.cidr_block
}