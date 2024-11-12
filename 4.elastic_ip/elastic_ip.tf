provider "aws" {
    region = "us-west-1"
}

resource "aws_eip" "elastic-ip-aws" {
  domain   = "vpc"
}