provider "aws" {
    region = "us-west-1"
}

resource "aws_iam_user" "lb-iam-user" {
  name = "sample-iam-user.${count.index}"
  count = 5
  path = "/system/"
}

output "arns_iam_users" {
  value = aws_iam_user.lb-iam-user[*].arn
}

/* terraform graph | dot -Tsvg > graph.svg */