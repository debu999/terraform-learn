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
