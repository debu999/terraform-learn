provider "aws" {
    region = "us-west-1"
}

resource "aws_iam_user" "iam-user-via-function" {
    name = "sample-iam-user"
}

resource "aws_iam_user_policy" "iam-user-policy-ec2-asg" {
    name = "iam-user-policy-ec2-asg"
    user = aws_iam_user.iam-user-via-function.name
    policy = file("iam-user-policy-ec2-asg.json")
}

/*
more functions
lookup(var.ami, var.region) -- lookup in var.ami map based on var.region
element(var.tags, count.index) - get the element from var.tags based on the index passed by count.index
length(var.tags) -- no. of entries in var.tags
timestamp() -- current timestamp to add in created_on etc. its in utc
formatdate("YYYY-MM-DD", timestamp()) -- current date timestamp
*/