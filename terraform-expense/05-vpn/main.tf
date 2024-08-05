module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.vpn.key_name
  name = "${var.project_name}-${var.environment}-vpn"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [ data.aws_ssm_parameter.vpn_sg_id.value ]
  ami = data.aws_ami.ami_id.id
  subnet_id              = local.public_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}

resource "aws_key_pair" "vpn" {
  key_name   = "vpn"
  public_key = file("~/.ssh/openvpn.pub")
  
}
