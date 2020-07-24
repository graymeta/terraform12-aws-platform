module "file_api_bucket" {
  source = "./file_api"

  bucket_name = var.file_api_bucket
  region      = var.region
}

