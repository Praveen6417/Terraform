# output "availability_zones_list" {
#   value = data.aws_availability_zones.availability_zone.names
# }

output "vpc" {
  value = module.aws_vpc.vpc
}

# output "length_public_subnets" {
#   value = length(aws_subnet.expense-public[*].id)
# }

# output "default_vpc_id" {
#   value = data.aws_vpc.default_vpc.id
# }

# output "default_route_vpc" {
#   value = data.aws_route_table.default_route_vpc.id
# }

# output "associated_subnet_ids" {
#   value = aws_route_table_association.public_route[*].subnet_id
# }

# output "public_subnet_ids" {
#   value = aws_subnet.expense-public[*].id
# }

# output "private_subnet_ids" {
#   value = aws_subnet.expense-private[*].id
# }

# output "private_db_subnet_ids" {
#   value = aws_subnet.expense-private-db[*].id
# }

# output "private_db_subnet_group_id" {
#   value = aws_db_subnet_group.db_group.id
# }

# output "private_db_subnet_group_name" {
#   value = aws_db_subnet_group.db_group.name
# }