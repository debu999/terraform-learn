# terraform state
# # list show all resources
# # mv - this more like rename a resource name in terraform viz. terraform state mv aws_vpc_security_group_ingress_rule.state-sg-ingress-rule-80 aws_vpc_security_group_ingress_rule.state-sg-ingress-rule-http
# # # then we can easily update the config in the .tf file
# # pull -- terraform state pull
# # push
# # rm -- terraform state rm --- remove from the statefile but not destroy it
# # show -- show specific resource viz. terraform state show aws_security_group.sg_sample
# # replace-provider

resource "aws_iam_user" "state-iam-user" {
  name = "state-iam-user"
}

resource "aws_security_group" "state-sg" {
  name = "state-sg"
}

resource "aws_vpc_security_group_ingress_rule" "state-sg-ingress-rule-80" {
  security_group_id = aws_security_group.state-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# resource "aws_vpc_security_group_ingress_rule" "state-sg-ingress-rule-22" {
#   security_group_id = aws_security_group.state-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   to_port           = 22
#   ip_protocol       = "tcp"
# }

output "sgrule_id" {
  value = aws_vpc_security_group_ingress_rule.state-sg-ingress-rule-80.id
}

output "sg_id" {
  value = aws_security_group.state-sg.id
}

output "user_id" {
  value = aws_iam_user.state-iam-user.id
}

