variable "instance_type" {
    type = map
    default = {
        db = "t2.small"
        backend = "t2.micro"
        frontend = "t2.micro"
    }
}

variable "common_tags" {
    type = map
    default = {
        Project = "Expense"
        Terraform = "true"
    }
}