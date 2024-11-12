provider "aws" {
    region = "us-west-1"
}

locals  {
    environment = { 
        env = "development"
    }
    region = {
        reg = "us-east-1"
    }
    priority = {
        val = 0
    }
}

output "env" {
  value = local.environment.env
  }

output "region" {
    value = "${local.region.reg}"
}

output "priority" {
  value = local.priority.val
}

/*
local cant be overridden
variables overridden via env vars, .tfvars file and cli
*/