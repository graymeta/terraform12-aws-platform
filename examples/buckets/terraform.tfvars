# platform_instance_id - Pick a platform instance id for this deployment of the GrayMeta platform. 
# A short, descriptive name like production, labs, test, etc. that can be used to uniquely identify 
# this deployment of the GrayMeta Platform within your environment.
platform_instance_id = "test"

# profile - AWS api profile to use on deployment
profile = "default"

# region - Pick which AWS region you want to deploy into from the list: 
# us-east-1, us-east-2, us-west-2, ap-southeast-2, eu-west-1
region = "us-east-1"

# custom_labels_bucket - S3 bucket name to use during AWS Custom Labels service
custom_labels_bucket = "test-cust-labels"

# file_api_bucket - S3 bucket name to store thumbnails, transcoded video and audio preview files, and metadata files. 
file_api_bucket = "test-file-api"

# temp_bucket - S3 bucket name to store temporary files for different ML services.
temp_bucket = "test-temp"

# usage_bucket - S3 bucket name to store usage reports.
usage_bucket = "test-usage"
