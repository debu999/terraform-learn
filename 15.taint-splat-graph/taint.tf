provider "aws" {
  region = "us-west-1"
}

data "aws_ami" "free_tier_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

output "ami_amazon_linux_id" {
  value = data.aws_ami.free_tier_ami.id
}

resource "aws_instance" "taint_ec2" {
    ami = data.aws_ami.free_tier_ami.id
    instance_type = "t2.micro"
    tags = {
        Name = "taint_ec2"
    }
}

# terraform apply -replace="aws_instance.taint-ec2"