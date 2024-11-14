# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "sg-0e206fea02eddc63b"
resource "aws_security_group" "tf-import-security-group" {
  description = "tf-import-sg"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "terraform managed outbout all traffic"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "terraform managed ssh inbound"
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "terraform managed tcp inbound"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 90
  }]
  name                   = "tf-import-sg"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags = {
    managed_by = "terraform"
  }
  tags_all = {
    managed_by = "terraform"
  }
  vpc_id = "vpc-008fe2d9ed1a19685"
}
