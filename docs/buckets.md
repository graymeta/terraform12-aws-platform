# Creating S3 Buckets
The platform needs four S3 buckets to be created prior to deployment. 

### Variables

* `platform_instance_id` - Pick a _platform instance id_ for this deployment of the GrayMeta platform. A short, descriptive name like `production`, `labs`, `test`, etc. that can be used to uniquely identify this deployment of the GrayMeta Platform within your environment.
* `profile` - AWS API profile to use on deployment.
* `region` - Pick which AWS region you want to deploy into from the list: us-east-1, us-east-2, us-west-2, ap-southeast-2, eu-west-1
* `file_api_bucket` - Create an S3 bucket to store thumbnails, transcoded video and audio preview files, and metadata files.  
* `usage_bucket` - Create an S3 bucket to store usage reports.
* `temp_bucket` - Used for specific ML services to transfer files.
* `custom_labels_bucket` - Used for the AWS Rekognition Custom Labels services.

### Install steps
* Download the example code in `examples/buckets/`
* Update the `terraform.tfvars` files.
* Deploy `terraform init` `terraform plan` `terraform apply`.
