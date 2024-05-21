resource "aws_instance" "sample" {
  count = length(var.instance_names)
  ami = var.ami_id
  vpc_security_group_ids = local.vpc_security_group_ids
  instance_type = local.instance_types[var.instance_names[count.index]]

  tags = merge(
      var.common_tags, 
      {
        Name = var.instance_names[count.index]
      }
  )
}

resource "aws_security_group" "allow_all" {
    name= "allow_all"
    description= "Allowing everything"
  
  ingress {
    from_port   = var.ingress_port_no
    to_port     = var.ingress_port_no
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }

  tags = {
    Name= "allow_all"
  }
  
}