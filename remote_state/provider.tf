terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.50.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-iron-man"
    key            = "remote-state"
    region         = "us-east-1"
    dynamodb_table = "terraform-iron-man-locking"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}