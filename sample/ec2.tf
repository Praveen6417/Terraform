resource "aws_instance" "sample" {
    ami = "ami-090252cbe067a9e58"
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_security_group.sg_id.id]
    tags = {
      name = "sample"
    }
}

# resource "aws_security_group" "allow_all" {
#     name= "allow_all"
#     description= "Allowing everything"
  
#   ingress {
#     from_port   = var.ingress_port_no
#     to_port     = var.ingress_port_no
#     protocol    = "tcp"
#     cidr_blocks = var.cidr_blocks
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = var.cidr_blocks
#   }

#   tags = {
#     Name= "allow_all"
#   }
  
# }