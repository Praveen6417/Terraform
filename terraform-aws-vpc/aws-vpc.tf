resource "aws_vpc" "expense" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "expense_gateway" {
  vpc_id = aws_vpc.expense.id

  tags = {
    Name = "expense-gateway"
  }
}

resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_subnet" "expense-public" {
    count = length(var.public_subnet)
    vpc_id = aws_vpc.expense.id
    availability_zone = local.availability_zone[count.index]
    cidr_block = var.public_subnet[count.index]

    tags = {
      Name = "expense-public-frontend"
    }
}

resource "aws_subnet" "expense-private" {
    count = length(var.private_subnet)
    vpc_id = aws_vpc.expense.id
    availability_zone = local.availability_zone[count.index]
    cidr_block = var.private_subnet[count.index]

    tags = {
      Name = "expense-private-backend"
    }
}

resource "aws_subnet" "expense-private-db" {
    count = length(var.database_subnet)
    vpc_id = aws_vpc.expense.id
    availability_zone = local.availability_zone[count.index]
    cidr_block = var.database_subnet[count.index]

    tags = {
      Name = "expense-private-database"
    }
}

resource "aws_db_subnet_group" "db_group" {
  name = "db-subnet-group"
  description = "Subnet group for private DB subnets"
  subnet_ids = aws_subnet.expense-private-db[*].id

   tags = {
    Name = "private-db-subnet-group"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.expense.id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.expense.id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public_route" {
  count = length(aws_subnet.expense-public[*].id)
  subnet_id      = element(aws_subnet.expense-public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_route" {
  count = length(aws_subnet.expense-private[*].id)
  subnet_id      = element(aws_subnet.expense-private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_route_db" {
  count = length(aws_subnet.expense-private-db[*].id)
  subnet_id      = element(aws_subnet.expense-private-db[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public.id
  gateway_id = aws_internet_gateway.expense_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private.id
  gateway_id = aws_nat_gateway.example.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.expense-public[0].id

  tags = {
    Name = "gw NAT"
  }
}