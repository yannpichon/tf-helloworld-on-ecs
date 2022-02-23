resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_range
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name        = "vpc-${var.environment}"
    environment = var.environment
  }
}

resource "aws_subnet" "public_subnet" {
  for_each = var.public_subnet

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_range
  map_public_ip_on_launch = "true"
  availability_zone       = each.value.availability_zone

  tags = {
    Name        = "${each.key}-${var.environment}"
    type        = "public-subnet"
    environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "igw-${var.environment}"
    environment = var.environment
  }
}

resource "aws_route_table" "igw_routing_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "igw-rt-${var.environment}"
    environment = var.environment
  }
}

resource "aws_route_table_association" "igw_rta" {
  for_each = var.public_subnet

  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.igw_routing_table.id
}