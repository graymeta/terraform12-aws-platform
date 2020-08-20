provider "aws" {
  region = "us-east-1"
}

module "buckets" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/buckets?ref=v0.0.1"

  platform_instance_id = "acme"

  custom_labels_bucket = "acme-cust-labels"
  file_api_bucket      = "acme-file-api"
  temp_bucket          = "acme-temp"
  usage_bucket         = "acme-usage"
}
