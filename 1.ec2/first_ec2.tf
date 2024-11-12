provider "aws" {
    region = "us-west-1"
    # secret_key = USE ENV VAR OR awscli viz. aws configure
    # access_key = USE ENV VAR OR awscli viz. aws configure
}

resource "aws_instance" "first_ec2_terraform" {
    ami = "ami-0cf4e1fcfd8494d5b"
    instance_type = "t2.micro"
    tags = {
        Name = "first_ec2_terraform"
    }
}