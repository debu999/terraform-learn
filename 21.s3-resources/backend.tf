# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-bucket-s3-backend"
#     key            = "terraform.tfstate"
#     dynamodb_table = "terraform-state"
#     region         = "us-west-1"
#   }
# }

terraform {
  backend "local" {}
}
