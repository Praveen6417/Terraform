locals {
  private_subnet_ids = element(split(",", data.aws_ssm_parameter.private_subnets.value),0)
}