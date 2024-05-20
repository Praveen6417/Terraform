# output "aws_instance"{
#     value = aws_instance.sample[*].public_ip
# }

# using lookup

output "database_instance_public_ip" {
  value = lookup(
    zipmap(
        aws_instance.sample[*].tags["Name"], 
        aws_instance.sample[*].public_ip), "DataBase")
}

# using element

/* output "database_instance_public_ip" {
  value = element(
    aws_instance.sample[*].public_ip,
    index(
      aws_instance.sample[*].tags,
      { Name = "DataBase" }
    )
  )
} */
