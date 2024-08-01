resource "aws_security_group" "allow_tls" {
  name        = "${var.project_name}-${var.environment}-${var.sg_name}"
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }

  dynamic "ingress" {
    for_each = var.inbound_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_blocks
      protocol = ingress.value.protocol
    }
  }

  dynamic "egress" {
    for_each = var.outbound_rules
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      cidr_blocks = egress.value.cidr_block
      protocol = egress.value.protocol
    }
  }
}