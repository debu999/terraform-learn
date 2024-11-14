terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.75.0"
    }
  }
}

variable region {
  default = "us-west-1"
}

variable "ec2_name" {
  default = "default_ec2"
}

variable instance-type {
  default = "t2.micro"
}
provider "aws" {
  region = var.region
}

data "aws_ami" "free_tier_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "default_ec2" {
  ami           = data.aws_ami.free_tier_ami.id
  instance_type = var.instance-type
  tags = {
    Name = var.ec2_name
  }
}

output "instance_id" {
  value = aws_instance.default_ec2.id
}