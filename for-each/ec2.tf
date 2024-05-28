resource "aws_instance" "sample" {
  for_each = var.instance_type
  ami = "ami-090252cbe067a9e58"
  vpc_security_group_ids = ["sg-01c708a3c8820c900"]
  instance_type = each.value

  tags = merge(
    var.common_tags, 
  {
    Name = each.key 
  }
  )
}

