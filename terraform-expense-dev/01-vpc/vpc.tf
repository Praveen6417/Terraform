module "aws_vpc" {
  source = "../../terraform-aws-vpc"
  public_subnet = var.aws_public_subnet
  private_subnet = var.aws_private_subnet
  database_subnet = var.aws_database_subnet
  is_peering_required = var.is_peering_required
}