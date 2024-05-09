resource "aws_instance" "sample" {
  ami = "ami-090252cbe067a9e58"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  instance_type = "t2.micro"

  tags = {
    Name= "HelloTerraform"
  }
}

resource "aws_security_group" "allow_all" {
    name= "allow_all"
    description= "Allowing everything"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}