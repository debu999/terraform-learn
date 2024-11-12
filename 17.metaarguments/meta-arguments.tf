provider "aws" {
  region = "us-west-1"
}

// depends_on, count, for_each, lifecycle, provider


/*
  lifecycle {
    ignore_changes = ["tags"]
    create_before_destroy = true // default is destroy and create
    prevent_destroy = true // it wont destroy till this is in the resource meta-arguments
    replace_triggered_by = ["aws_instance.example"]
    ignore_changes = all // ignore all changes
  }
*/

variable users-list {
  type = list(string)
  #   default = ["user1", "user2", "user3"]
  default = ["user1", "user2", "user3", "user4"] // ["user1", "user2", "user3"] -> ["user1", "user2", "user3", "user4"] no issues ordering matters
  // default = ["user0", "user1", "user2", "user3", "user4"] // ["user1", "user2", "user3"] -> ["user0", "user1", "user2", "user3", "user4"] issue as ordering changes
}

resource "aws_iam_user" "users-resource-var-count" {
    name = "iam-${var.users-list[count.index]}"
    count = 4
}

variable var-list {
  type = list(object({
    name = string
    age = number
  }))
  default = [
    {
      name = "user1"
      age = 20
    },
    {
      name = "user2"
      age = 30
    },
    {
      name = "user3"
      age = 40
    }
  ]
}

variable var-set {
  type = set(object({
    name = string
    age = number
  }))
  default = [
    {
      name = "user1"
      age = 20
    },
    {
      name = "user2"
      age = 30
    },
    {
      name = "user1"
      age = 20
    }
  ]
}

output out-var-list {
  value = var.var-list
}

output "out-var-set" {
  value = var.var-set
}

variable users-list2 {
  type = set(string)
  #   default = ["user1", "user2", "user3"]
  default = ["user1", "user2", "user3", "user4"] // ["user1", "user2", "user3"] -> ["user1", "user2", "user3", "user4"] no issues ordering matters
  // default = ["user0", "user1", "user2", "user3", "user4"] // ["user1", "user2", "user3"] -> ["user0", "user1", "user2", "user3", "user4"] issue as ordering changes
}

resource "aws_iam_user" "users-resource-var-foreach" {
  name = "iam-${each.value}-new"
  for_each = var.users-list2
}

// we have each.key and each.value for list/set key and value are same
// for map we have key and value different
