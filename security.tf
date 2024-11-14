
provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "ue1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "ue2"
}

provider "aws" {
  region = "us-west-2"
  alias  = "uw2"
}

# resource "aws_security_group" "region-sg" {
#   name = "state-sg"
# }
# resource "aws_security_group" "region-sg-ue1" {
#   name     = "state-sg"
#   provider = aws.ue1
# }

# resource "aws_security_group" "region-sg-ue2" {
#   name     = "state-sg"
#   provider = aws.ue2
# }
# resource "aws_security_group" "region-sg-uw2" {
#   name     = "state-sg"
#   provider = aws.uw2
# }

variable "sensitive_creds" {
  type = string
  sensitive = true
  default = "gibberish_new"
}

resource "local_file" "sensitive_creds_file" {
  content  = var.sensitive_creds
  filename = "sensitive_creds.txt"
}

resource "local_sensitive_file" "sensitive_creds_file" {
  content  = "gibberish_data"
  filename = "sensitive_creds1.txt"
}

output "sensitive_creds_out" {
  value = var.sensitive_creds
  sensitive = true
}

output "sensitive_creds_fromfile_out" {
  value = local_sensitive_file.sensitive_creds_file.content
  sensitive = true
}
