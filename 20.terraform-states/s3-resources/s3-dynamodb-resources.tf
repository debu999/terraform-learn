provider "aws" {
    region = "us-west-1"
}

resource "aws_s3_bucket" "terraform-state-bucket" {
  bucket = "terraform-state-bucket-s3-backend"
  tags = {
    Name = "S3 Remote Terraform State Store"
  }
}

resource "aws_s3_bucket_versioning" "versioning_terraform-state-bucket" {
  bucket = aws_s3_bucket.terraform-state-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_terraform-state-bucket" {
  bucket = aws_s3_bucket.terraform-state-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_object_lock_configuration" "lock_terraform-state-bucket" {
  bucket = aws_s3_bucket.terraform-state-bucket.id
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}