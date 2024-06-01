resource "aws_instance" "sample" {
  ami = data.aws_ami.ami_info.id
  vpc_security_group_ids = ["sg-01c708a3c8820c900"]
  instance_type = "t2.micro"

  tags = {
    Name= "HelloTerraform"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-iron-man"
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-iron-man-locking"
  hash_key     = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}