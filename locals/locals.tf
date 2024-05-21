locals {
  instance_types = {
    for name in var.instance_names :
    name => name == "DataBase" ? "t2.small" : "t2.micro"
  }
  vpc_security_group_ids = [aws_security_group.allow_all.id]
}
