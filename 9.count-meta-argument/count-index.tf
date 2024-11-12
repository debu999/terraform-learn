provider "aws" {
    region = "us-west-1"
}

/*
resource "aws_instance" "two_ec2_instance_count" {
    ami = "ami-05c65d8bb2e35991a"
    instance_type = "t2.micro"
    tags = {
        Name = "sample-ec2-${count.index}"
        Program = "terraform"
    }
    count = 2
}
*/

resource "aws_iam_user" "users-resource" {
    name = "user-${count.index}"
    count = 3
}

variable "users" {
    type = list(string)
    default = ["user1", "user2", "user3"]
}

resource "aws_iam_user" "users-resource-2" {
    name = "engineer-${var.users[count.index]}"
    count = length(var.users)
}