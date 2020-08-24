# Creating S3 Buckets
For deploying we will need to create 4 s3 buckets.

### Variables
* `platform_instance_id` - Pick a _platform instance id_ for this deployment of the GrayMeta platform. A short, descriptive name like `production`, `labs`, `test`, etc. that can be used to uniquely identify this deployment of the GrayMeta Platform within your environment.

* `file_api_bucket` - Create an S3 bucket to store thumbnails, transcoded video and audio preview files, and metadata files.  
* `usage_bucket` - Create an S3 bucket to store usage reports.
* `temp_bucket` - Used for specific ML services to transfer files
* `custom_labels_bucket` - Used for the AWS Rekognition Custom Labels services

```
provider "aws" {
  region  = "us-east-1"
}

module "buckets" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/buckets?ref=master"

  platform_instance_id = "acme"

  custom_labels_bucket = "acme-cust-labels"
  file_api_bucket      = "acme-file-api"
  temp_bucket          = "acme-temp"
  usage_bucket         = "acme-usage"
}
```