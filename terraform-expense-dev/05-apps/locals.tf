locals {
  public_subnet_ids = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value),0)
}

locals {
  private_subnet_ids = element(split(",", data.aws_ssm_parameter.private_subnet_ids.value),0)
}