terraform {
  required_version = ">= 1.0"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "speg03-sandbox-terraform-state-sample-bucket"
  region = "ap-northeast-1"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
