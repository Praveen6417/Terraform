data "aws_security_group" "sg_id" {
    filter {
      name = "group-name"
      values = [ "allow_all" ]
    }

    filter {
      name = "vpc-id"
      values = [ "vpc-0161c7af78e0789e1" ]
    }
}