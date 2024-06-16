variable "aws_public_subnet" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "aws_private_subnet" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "aws_database_subnet" {
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "is_peering_required" {
  default = true
}

variable "project_name" {
    default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}