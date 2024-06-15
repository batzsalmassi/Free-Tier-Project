output "vpc_id" {
  value = aws_vpc.mainVPC.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main-igw.id
}

output "public_route_table_id" {
    value = aws_route_table.public-rt.id
}

output "private_route_table_id" {
    value = aws_route_table.private-rt.id
}

