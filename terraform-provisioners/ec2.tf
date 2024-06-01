resource "aws_instance" "sample" {
  ami = data.aws_ami.ami_info.id
  vpc_security_group_ids = ["sg-01c708a3c8820c900"]
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.sample.private_ip} > private_ip.txt"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo dnf install ansible -y",
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx",
      "sudo dnf install graphviz -y"
     ]
  }

  tags = {
    Name= "HelloTerraform"
  }
}

