resource "aws_s3_bucket" "file_api_s3_bucket" {
  bucket = var.bucket_name
  region = var.region
}

resource "aws_s3_bucket_public_access_block" "file_api_s3_bucket" {
  bucket                  = aws_s3_bucket.file_api_s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
