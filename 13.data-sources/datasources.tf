provider "aws" {
  region = "us-west-1"
}

/*
datasource fetch data from external systems
ex1 - read from account aws

*/

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

data "local_file" "spiritual" {
  filename = "${path.module}/data.txt"
}
/*
output spiritual_content {
  value = data.local_file.spiritual.content
}
*/
output "spiritual_content_base64sha256" {
  value = data.local_file.spiritual.content_base64sha256
}

locals {
  environment = {
    env = "development"
  }
  region = {
    reg = "us-east-1"
  }
  priority = 0
}
/*
resource "aws_instance" "datasource-ami" {
    ami = "ami-05c65d8bb2e35991a"
    instance_type = local.environment.env == "development" ? "t2.micro" : "t3.micro"
    tags = {
        Name = "sample-ec2-${local.environment.env == "development" ? "small-ec2" : "medium-ec2"}"
        Program = "terraform"
        mapping = "${local.environment.env == "development" && local.priority == 0 ? "${local.region.reg}-${local.priority}" : local.region.reg}"
    }
}
locals {
  ec2_id = aws_instance.datasource-ami.id
}

output "ami_id" {
  value = local.ec2_id
}

data "aws_instances" "ec2_instances" {
  depends_on = [
    aws_instance.datasource-ami
  ]
}
*/

/*
  this {} is for filter viz. {filter{name=image-id}
  data "aws_instance" "ec2_tag_dev" {
    filter {
      name = "tag:env"
      values = ["sample-ec2-small-ec2"]
    }
  }
*/
/*
output awsinstances {
  value = data.aws_instances.ec2_instances
}
*/

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

/*
ENV VARIABLES
TF_LOG=TRACE
TF_LOG_PATH=terraform.log
*/