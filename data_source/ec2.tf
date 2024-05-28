resource "aws_instance" "sample" {
  ami = var.ami_id
  count = length(var.instance_names)
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  instance_type = var.instance_names[count.index]

  tags = {
    Name= "HelloTerraform"
  }
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