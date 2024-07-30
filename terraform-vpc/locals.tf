locals {
  availability_zone = slice(data.aws_availability_zones.availability_zone.names, 0, 2)
}