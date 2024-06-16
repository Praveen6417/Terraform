variable "project_name" {
  type = string
  default = "expense"
}

variable "environment" {
  type = string
  default = "dev"
}


# variable "sg_name" {
#   default = aws_security_group.allow_tls.Name
# }

variable "description" {
  default = "SG for DataBase Instance"
}