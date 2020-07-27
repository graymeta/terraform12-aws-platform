module "file_api_bucket" {
  source = "./file_api"

  bucket_name = var.file_api_bucket
  region      = var.region
}

module "custom_labels_bucket" {
  source = "./custom_labels"

  bucket_name = var.custom_labels_bucket
  region      = var.region
  platform_instance_id = var.platform_instance_id
}

module "temp_bucket" {
  source = "./temp"

  bucket_name = var.temp_bucket
  region      = var.region
}

module "usage_bucket" {
  source = "./usage"

  bucket_name = var.usage_bucket
  region      = var.region
}