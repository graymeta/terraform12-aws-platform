resource "aws_s3_bucket" "usage_s3_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "usage_s3_bucket" {
  bucket                  = aws_s3_bucket.usage_s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
