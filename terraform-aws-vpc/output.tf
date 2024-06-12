output "availability_zones_list" {
  value = data.aws_availability_zones.availability_zone.names
}

output "vpc" {
  value = aws_vpc.expense.id
}

output "length_public_subnets" {
  value = length(aws_subnet.expense-public[*].id)
}

output "default_vpc_id" {
  value = data.aws_vpc.default_vpc.id
}

output "default_route_vpc" {
  value = data.aws_route_table.default_route_vpc.id
}