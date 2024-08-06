data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnets"
}

data "aws_ssm_parameter" "frontend_sg_id" {
  name = "/${var.project_name}/${var.environment}/frontend_sg_id"
}

data "aws_ssm_parameter" "web-alb-aws_lb_listener" {
  name = "/${var.project_name}/${var.environment}/web-alb-listener"
}

data "aws_ami" "ami_id" {
  most_recent = true
  owners = [ "973714476881" ]

  filter {
    name = "name"
    values = ["RHEL-9-DevOps-Practice"]
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