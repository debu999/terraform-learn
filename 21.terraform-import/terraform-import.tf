provider "aws" {
  region = "us-west-1"
}

data "aws_security_group" "tf-import-security-group" {
  name = "tf-import-sg"
}

import {
    to = aws_security_group.tf-import-security-group
    id = data.aws_security_group.tf-import-security-group.id
}

# terraform plan -generate-config-out=terraform-import-security-group.tf