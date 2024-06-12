resource "aws_vpc_peering_connection" "vpc_peering" {
    count = var.is_peering_required ? 1 : 0
    vpc_id = aws_vpc.expense.id
    peer_vpc_id = data.aws_vpc.default_vpc.id
    auto_accept = var.acceptor_vpc_id == "" ? true : false
  tags = {
    Name = "expense-peering"
  }
}

resource "aws_route" "public_route_peering" {
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  route_table_id = aws_route_table.public.id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering[0].id
}

resource "aws_route" "private_route_peering" {
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  route_table_id = aws_route_table.private.id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering[0].id
}

resource "aws_route" "default_route_peering" { 
  destination_cidr_block = var.cidr_block
  route_table_id = data.aws_route_table.default_route_vpc.id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering[0].id
}
