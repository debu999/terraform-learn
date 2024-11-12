terraform {
    required_version = ">= 1.9.4"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">=5.4.0"
        }
    }
}
provider "aws" {
    region = "us-west-1"
}

resource "local_file" "sample_file" {
    filename = "hello.txt"
    content = "new hello world"
}

# terraform plan -out infra.plan
# terraform apply infra.plan
# terraform show 16.plan-output/infra.plan
# terraform show -json 16.plan-output/infra.plan | jq
# terraform output iam_arns
# terraform output iam_names


resource "aws_iam_user" "users-resource-output" {
    name = "user-${count.index}"
    count = 3
}

output "iam_arns" {
    value = aws_iam_user.users-resource-output[*].arn
}

output "iam_names" {
    value = aws_iam_user.users-resource-output[*].name
}

# terraform plan -target aws_iam_users.users-resource-output
# terraform apply -target aws_iam_users.users-resource-output
# terraform destroy -target aws_iam_users.users-resource-output
# terraform plan -target="aws_iam_users.users-resource-output"
# terraform apply -target="aws_iam_users.users-resource-output"
# terraform destroy -target="aws_iam_users.users-resource-output"
# terraform plan -refresh=false

locals {
    key_val_map = zipmap(["key1", "key2", "key3"], ["value1", "value2", "value3"])
}
output "new_zipmap" {
    value = local.key_val_map
}

// comments have # // /*. */