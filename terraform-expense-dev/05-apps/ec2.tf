module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-ansible"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [ data.aws_ssm_parameter.ansible_sg_id.value ]
  ami = data.aws_ami.ami_id.id
  subnet_id              = local.public_subnet_ids

  user_data = file("expense.sh")

  depends_on = [ module.frontend, module.backend ]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-ansible"
    }
  )
}

module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-frontend"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [ data.aws_ssm_parameter.frontend_sg_id.value ]
  ami = data.aws_ami.ami_id.id
  subnet_id              = local.public_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-frontend"
    }
  )
}

module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-backend"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [ data.aws_ssm_parameter.backend_sg_id.value ]
  ami = data.aws_ami.ami_id.id
  subnet_id              = local.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-backend"
    }
  )
}