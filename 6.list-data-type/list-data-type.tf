provider "aws" {
  region = "us-west-1"
}

variable number-list {
  type = list(number)
  default = [1, 2, 3]
}

/*
resource "aws_instance" "second_ec2_terraform" {
    ami = "ami-0cf4e1fcfd8494d5b"
    instance_type = "t2.micro"
    tags = {
        Name = "second_ec2_terraform"
    }
    vpc_security_group_ids = ["sg-12345678", "sg-2345678"]
}
*/

variable string-list {
  type = list(string)
  default = ["a", "b", "c"]
}

output "string-list-out" {
  value = var.string-list
}

output "number-list" {
  value = var.number-list
}