resource "aws_security_group" "sample" {
    name = "example-security-group"

    dynamic "ingress" {
        for_each = var.inbound-rules
        content {
          from_port = ingress.value.from_port
          to_port = ingress.value.to_port
          cidr_blocks = ingress.value.cidr_blocks
          protocol = ingress.value.protocol
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}