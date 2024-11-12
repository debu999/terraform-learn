provider "aws" {
    region = "us-west-1"
}

variable string-map {
  type = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
  }
}

variable number-map {
  type = map(number)
    default = {
    key1 = "1"
    key2 = "2"
    key3 = "3"
  }
}

/*
resource "aws_instance" "third_ec2_terraform" {
    ami = "ami-0cf4e1fcfd8494d5b"
    instance_type = "t2.micro"
    tags = {
        Name = "third_ec2_terraform"
        Program = "terraform"
    }
    vpc_security_group_ids = ["sg-12345678", "sg-2345678"]
}
*/

variable s-list {
  type = list(string)
  default = ["a", "b", "c"]
}

output "string-map" {
  value = var.string-map
}

output "number-map" {
  value = var.number-map
}

output "map-key-key3" {
  value = var.number-map["key3"]
}

output "list-position-1" {
  value = var.s-list[1]
}