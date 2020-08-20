data "aws_region" "current" {}

resource "aws_s3_bucket" "temp_s3_bucket" {
  bucket = var.bucket_name
  region = data.aws_region.current.name
}

resource "aws_s3_bucket_public_access_block" "temp_s3_bucket" {
  bucket                  = aws_s3_bucket.temp_s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
