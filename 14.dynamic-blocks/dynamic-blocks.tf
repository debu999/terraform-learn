provider "aws" {
  region = "us-west-1"
}

variable "sg_ports" {
  type = list(number)
  default = [22, 80, 443, 1500, 1245]
}

resource "aws_security_group" "dynamic_sg" {
  name = "dynamic_sg"
  description = "Dynamic Security Group"
  tags = {
    Name = "dynamic_sg"
  }

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = sg_ingress_port
    content {
      from_port = sg_ingress_port.value
      to_port = sg_ingress_port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    iterator = sg_egress_port
    content {
      from_port = sg_egress_port.value
      to_port = sg_egress_port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# terraform validate will help validate the file in terraform instead of terraform plan