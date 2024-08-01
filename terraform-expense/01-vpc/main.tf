module "aws_vpc" {
  source = "../../terraform-vpc"
  public_subnet = var.public_subnet_cidrs
  private_subnet = var.private_subnet_cidrs
  database_subnet = var.database_subnet_cidrs
  is_peering_required = true
}