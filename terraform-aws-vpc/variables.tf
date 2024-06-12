variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "expense"
}

variable "public_subnet" {
  type = list 
  validation {
    condition = length(var.public_subnet) == 2
    error_message = "enter 2 valid public subnets"
  }
}

variable "private_subnet" {
  type = list 
  validation {
    condition = length(var.private_subnet) == 2
    error_message = "enter 2 valid private subnets"
  }
}

variable "database_subnet" {
  type = list 
  validation {
    condition = length(var.database_subnet) == 2
    error_message = "enter 2 valid database subnets"
  }
}

variable "is_peering_required" {
  type = bool
  default = false
}

variable "acceptor_vpc_id" {
  type = string
  default = ""
}