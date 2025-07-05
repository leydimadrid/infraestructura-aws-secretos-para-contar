data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "security_group" {
  description = "Security Group parametrizable"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.puertos
    content {
      description      = "Allow port ${ingress.value}"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "custom_sg"
  }
}
