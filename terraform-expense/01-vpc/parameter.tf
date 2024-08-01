resource "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
  type = "String"
  value = module.aws_vpc.vpc
}

resource "aws_ssm_parameter" "public_subnets" {
  name = "/${var.project_name}/${var.environment}/public_subnets"
  type = "StringList"
  value = join(",", module.aws_vpc.public_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnets" {
  name = "/${var.project_name}/${var.environment}/private_subnets"
  type = "StringList"
  value = join(",", module.aws_vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "private_db_subnets" {
  name = "/${var.project_name}/${var.environment}/private_db_subnets"
  type = "StringList"
  value = join(",", module.aws_vpc.private_db_subnet_ids)
}