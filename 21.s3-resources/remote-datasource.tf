data "terraform_remote_state" "infra_ids" {
  depends_on = [aws_vpc_security_group_ingress_rule.state-sg-ingress-rule-80,
  aws_iam_user.state-iam-user, aws_security_group.state-sg]
  backend = "s3"
  config = {
    bucket = "terraform-state-bucket-s3-backend"
    key    = "terraform.tfstate"
    region = "us-west-1"
  }
}


output "sgrule_id1" {
  value = try(data.terraform_remote_state.infra_ids.outputs.sgrule_id, "dymmy_sgrule_id")
}

output "sg_id1" {
  value = try(data.terraform_remote_state.infra_ids.outputs.sg_id, "dummy_sg_id")
}

output "user_id1" {
  value = try(data.terraform_remote_state.infra_ids.outputs.user_id, "dummy_user")
}
