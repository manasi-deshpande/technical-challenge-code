data "aws_region" "current" {}

# Key Resources List:
# 1 VPC
# 2 Subnets
# 2 Route Tables and their subnet associations
# 2 Gateways - Internet gateway for Public Subnet and NAT Gateway for Private Subnet
# Routes in Route Tables connecting to the right gateway
# TODO: create security groups

# VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
}

# Subnets
resource "aws_subnet" "private_subnet" {
  for_each = toset(var.availability_zone_list)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr_block
  map_public_ip_on_launch = false
  availability_zone = each.value
}

resource "aws_subnet" "public_subnet" {
  for_each = toset(var.availability_zone_list)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone = each.value
}

# Route Tables
resource "aws_route_table" "private_sb_rtb" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_sb_rtb" {
  vpc_id = aws_vpc.vpc.id
}

# Route Table subnet associations
resource "aws_route_table_association" "public_sb_rtb_assoc" {
  for_each = aws_subnet.public_subnet
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_sb_rtb.id
}

resource "aws_route_table_association" "private_sb_rtb_assoc" {
  for_each = aws_subnet.private_subnet
  subnet_id      = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.private_sb_rtb.id
}

# Gateways

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_eip" "nat_elastic_ip" {
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateway" {
  for_each = aws_subnet.public_subnet
  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = aws_subnet.public_subnet[each.key].id
  depends_on    = [aws_internet_gateway.internet_gateway]
}

# Routes

resource "aws_route" "ig_route" {
  route_table_id         = aws_route_table.public_sb_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route" "nat_gw_route" {
  for_each = aws_nat_gateway.nat_gateway
  route_table_id         = aws_route_table.private_sb_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[each.key].id
}

