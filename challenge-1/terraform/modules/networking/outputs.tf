output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "private_subnet_id" {
    value = [for sb in aws_subnet.private_subnet : sb.id]
}

output "public_subnet_id" {
    value = [for sb in aws_subnet.public_subnet : sb.id]
}

output "private_sb_rtb" {
  value = aws_route_table.private_sb_rtb.id
}

output "public_sb_rtb" {
  value = aws_route_table.public_sb_rtb.id
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway.id
}

output "nat_gateway" {
  value = aws_nat_gateway.nat_gateway[*]
}


