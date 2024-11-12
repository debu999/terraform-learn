provider "aws" {
    region = "us-west-1"
}

resource "aws_eip" "elastic_ip_aws" {
  domain   = "vpc"
}

resource "aws_security_group" "attribute_sg" {
  name        = "attribute_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "attribute_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_attributes_ipv4" {
  security_group_id = aws_security_group.attribute_sg.id
  cidr_ipv4         = "${aws_eip.elastic_ip_aws.public_ip}/32"
  from_port         = var.https_port
  ip_protocol       = "tcp"
  to_port           = var.https_port
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_attributes_ssh" {
  security_group_id = aws_security_group.attribute_sg.id
  cidr_ipv4         = "${aws_eip.elastic_ip_aws.public_ip}/32"
  from_port         = var.ssh_port
  ip_protocol       = "tcp"
  to_port           = var.ssh_port
}

