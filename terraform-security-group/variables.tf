variable "project_name" {
  type = string
  default = "expense"
}

variable "environment" {
  type = string
  default = "Dev"
}

variable "vpc_id" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "inbound_rules" {
  type = list
  default = []
}

variable "description" {
  type = string
  default = ""
}

variable "outbound_rules" {
  type = list 
  default = [{
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_block = ["0.0.0.0/0"]
    }
  ]
}