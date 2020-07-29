output "custom_labels_s3_bucket_arn" {
  value = module.custom_labels_bucket.custom_labels_s3_bucket_arn
}

output "file_api_s3_bucket_arn" {
  value = module.file_api_bucket.file_api_s3_bucket_arn
}

output "temp_s3_bucket_arn" {
  value = module.temp_bucket.temp_s3_bucket_arn
}

output "usage_s3_bucket_arn" {
  value = module.usage_bucket.usage_s3_bucket_arn
}
