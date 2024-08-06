data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/${var.project_name}/${var.environment}/bastion_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnets"
}

data "aws_ssm_parameter" "web-alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/web-alb_sg_id"
}

data "aws_ami" "ami_id" {
  most_recent = true
  owners = [ "679593333241" ]

  filter {
    name = "name"
    values = ["OpenVPN Access Server Community Image-fe8020db-*"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}