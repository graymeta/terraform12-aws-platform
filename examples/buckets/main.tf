provider "aws" {
  region  = var.region
  profile = var.profile
}

module "buckets" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/buckets?ref=v0.0.2"

  platform_instance_id = var.platform_instance_id

  custom_labels_bucket = var.custom_labels_bucket
  file_api_bucket      = var.file_api_bucket
  temp_bucket          = var.temp_bucket
  usage_bucket         = var.usage_bucket
}
