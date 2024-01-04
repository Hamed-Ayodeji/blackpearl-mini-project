# create a vpc for the mini-project

resource "aws_vpc" "vpc" {
  cidr_block              = var.cidr_block
  instance_tenancy        = "default"
  enable_dns_support      = true
  enable_dns_hostnames    = true
  tags                    = {
    Name                  = "${var.project-name}-mini-project-vpc"
  }
}

##############################################################

# create an internet gateway for the vpc
resource "aws_internet_gateway" "igw" {
  vpc_id                  = aws_vpc.vpc.id
  tags                    = {
    Name                  = "${var.project-name}-mini-project-igw"
  }
}

##############################################################

# create a data block for availability zones

data "aws_availability_zones" "available" {}

##############################################################

# create 3 public subnets in different availability zones

resource "aws_subnet" "subnets" {
  for_each                = {
    public-subnet-1       = 0
    public-subnet-2       = 1
    public-subnet-3       = 2
  }
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 4, each.value)
  availability_zone       = data.aws_availability_zones.available.names[each.value]
  map_public_ip_on_launch = true
  tags                    = {
    Name                  = "${var.project-name}-mini-project-${each.key}"
  }
}

##############################################################

# create a route table for the public subnets

resource "aws_route_table" "public-route-table" {
  vpc_id                  = aws_vpc.vpc.id
  route {
    cidr_block            = "0.0.0.0/0"
    gateway_id            = aws_internet_gateway.igw.id
  }
  tags                    = {
    Name                  = "${var.project-name}-mini-project-public-route-table"
  }
}

##############################################################

# associate the public subnets with the public route table

resource "aws_route_table_association" "public-route-table-association" {
  for_each                = aws_subnet.subnets
  subnet_id               = each.value.id
  route_table_id          = aws_route_table.public-route-table.id
}

##############################################################