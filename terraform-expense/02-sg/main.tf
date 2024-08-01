module "db" {
  source = "../../terraform-security-group"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "db"
  description = var.description
  project_name = var.project_name
  environment = var.environment
}

module "backend" {
  source = "../../terraform-security-group"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "backend"
  description = "SG for Backend Instances"
  project_name = var.project_name
  environment = var.environment
}

module "frontend" {
  source = "../../terraform-security-group"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "frontend"
  description = "SG for Frontend Instances"
  project_name = var.project_name
  environment = var.environment
}

module "bastion" {
  source = "../../terraform-security-group"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "bastion"
  description = "SG for Bastion Instances"
  project_name = var.project_name
  environment = var.environment
}

module "vpn" {
  source = "../../terraform-security-group"
  inbound_rules = var.inbound_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "vpn"
  description = "SG for vpn Instances"
  project_name = var.project_name
  environment = var.environment
}

module "app-alb" {
  source = "../../terraform-security-group"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "app-alb"
  description = "SG for app-alb Instances"
  project_name = var.project_name
  environment = var.environment
}

module "web-alb" {
  source = "../../terraform-security-group"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  sg_name = "web-alb"
  description = "SG for web-alb Instances"
  project_name = var.project_name
  environment = var.environment
}

resource "aws_security_group_rule" "db_backend" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_group_id = module.db.sg_id
  source_security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "db_bastion" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_group_id = module.db.sg_id
  source_security_group_id = module.bastion.sg_id
}

resource "aws_security_group_rule" "db_vpn" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_group_id = module.db.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "backend_app-alb" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  security_group_id = module.backend.sg_id
  source_security_group_id = module.app-alb.sg_id
}

resource "aws_security_group_rule" "backend_vpn-ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_vpn-http" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "frontend_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_vpn" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_web-alb" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.web-alb.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "bastion_internet" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

resource "aws_security_group_rule" "web-alb_internet-http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web-alb.sg_id
}

resource "aws_security_group_rule" "web-alb_internet-https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web-alb.sg_id
}

resource "aws_security_group_rule" "app-alb_frontend" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id = module.app-alb.sg_id
}

resource "aws_security_group_rule" "app-alb_vpn" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.app-alb.sg_id
}

resource "aws_security_group_rule" "app-alb_bastion" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.app-alb.sg_id
}