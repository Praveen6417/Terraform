data "aws_availability_zones" "availability_zone" {
  state = "available"
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_route_table" "default_route_vpc" {
  vpc_id = data.aws_vpc.default_vpc.id

  filter {
    name = "association.main"
    values = [ "true" ]
  }
}
