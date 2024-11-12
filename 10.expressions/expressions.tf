provider "aws" {
    region = "us-west-1"
}

variable "environment" {
    type = string
    default = "development"
}

variable "region" {
    type = string
    default = "us-east-1"
}

variable "priority" {
    type = number
    default = 0
}

resource "aws_instance" "expression-ami" {
    ami = "ami-05c65d8bb2e35991a"
    instance_type = var.environment == "development" ? "t2.micro" : "t3.micro"
    tags = {
        Name = "sample-ec2-${var.environment == "development" ? "small" : "medium"}"
        Program = "terraform"
        mapping = "${var.environment == "development" && var.priority == 1 ? "${var.region}-${var.priority}" : var.region}"
    }
}