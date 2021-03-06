# customer - Short name for you company.
customer = "mycompanyname"

# platform_instance_id - Pick a platform instance id for this deployment of the GrayMeta platform. 
# A short, descriptive name like production, labs, test, etc. that can be used to uniquely identify 
# this deployment of the GrayMeta Platform within your environment.
platform_instance_id = "test"

# profile - AWS api profile to use on deployment
profile = "default"

# region - Pick which AWS region you want to deploy into from the list: 
# us-east-1, us-east-2, us-west-2, ap-southeast-2, eu-west-1
region = "us-east-1"

# dns_name - Pick the hostname which will be used to access the platform 
# (example: graymeta.example.com).  Record this value as the dns_name variable.
dns_name = "foo.cust.graymeta.com"

# notifications_from_addr - Decide what email address will be used as the From: address for email notifications 
# generated by the platform. You must use a Verified SES email address for this address. 
# Submit a request to move out of the SES sandbox.
notifications_from_addr = "noreply@example.com"

# notifications_region - If you are using SES in a different region set the region here. 
# You can leave blank if SES is in the same region as the platform.
notifications_region = ""

# key_name - The default ssh key name to access the instances.
key_name = "somekey"

# ssl_certificate_arn - Procure a valid SSL certificate for the hostname chosen in the previous step. 
# Self-signed certificates will NOT work. Upload the SSL certificate to Amazon Certificate Manager in the 
# same region you will be deploying the platform into. After upload, record the ARN of the certificate 
# as variable ssl_certificate_arn
ssl_certificate_arn = ""

# gm_license_key - Contact support@graymeta.com if you have not been provided a license key. 
# Please include your dns_name in your request for a license. 
# If you added this variable to your encrypted_config_blob then you can set this to empty string. gm_license_key = ""
gm_license_key = ""

# Encryption Tokens - 32 character alpha numberic strings.
# If you added this variable to your encrypted_config_blob then you can set them to an empty string.
client_secret_fe            = "012345678901234567890123456789ab"
client_secret_internal      = "012345678901234567890123456789ab"
encryption_key              = "012345678901234567890123456789ab"
jwt_key                     = "012345678901234567890123456789ab"
oauthconnect_encryption_key = "012345678901234567890123456789ab"

# Using AWS KMS to encrypt secrets in the platform.  Leave blank if not using this.
# https://github.com/graymeta/terraform12-aws-platform/blob/master/docs/encryption.md
encrypted_config_blob = ""

# custom_labels_bucket - S3 bucket name to use during AWS Custom Labels service
custom_labels_bucket = "custom_labels_bucket"

# file_api_bucket - S3 bucket name to store thumbnails, transcoded video and audio preview files, and metadata files. 
file_api_bucket = "file_api_bucket"

# temp_bucket - S3 bucket name to store temporary files for different ML services.
temp_bucket = "temp_bucket"

# usage_bucket - S3 bucket name to store usage reports.
usage_bucket = "temp_bucket"

# az1 and az2 - The availablity zones to deploy in.
az1 = "us-east-1a"
az2 = "us-east-1b"

# VPC and Subnet Setup
cidr_vpc                    = "10.0.0.0/16"
cidr_subnet_ecs_1           = "10.0.8.0/21"
cidr_subnet_ecs_2           = "10.0.24.0/21"
cidr_subnet_elasticsearch_1 = "10.0.16.0/24"
cidr_subnet_elasticsearch_2 = "10.0.17.0/24"
cidr_subnet_mlservices_1    = "10.0.18.0/24"
cidr_subnet_mlservices_2    = "10.0.19.0/24"
cidr_subnet_proxy_1         = "10.0.20.0/24"
cidr_subnet_proxy_2         = "10.0.21.0/24"
cidr_subnet_public_1        = "10.0.0.0/24"
cidr_subnet_public_2        = "10.0.1.0/24"
cidr_subnet_rds_1           = "10.0.2.0/24"
cidr_subnet_rds_2           = "10.0.3.0/24"
cidr_subnet_services_1      = "10.0.4.0/24"
cidr_subnet_services_2      = "10.0.5.0/24"

# Decide the CIDR or CIDRs that will be allowed access to the platform. 
# Record as comma delimited lists of CIDR blocks.
# platform_access_cidrs - The list of CIDRs that will be allowed to access the web ports of the platform
# ssh_cidr_blocks - The list of CIDRs that will be allowed SSH access to the servers. This is typically 
#                   an admin or VPN subnet somewhere within your VPC.
platform_access_cidrs = "0.0.0.0/0"
ssh_cidr_blocks       = "10.0.0.0/16"

# log_retention - The log retention set in Cloudwatch for all logs. (days)
log_retention = 14

# RDS Postgres Services.  
rds_username         = "mydbuser"
rds_password         = "mydbpassword"
rds_backup_retention = 14

# RDS Snapshot to recover from.  After initial deployment this should be set to `rds_snapshot = "final"`
rds_snapshot = ""

# RDS Postgres MLServices.
# Password Constraints: At least 8 printable ASCII characters.
# Password can't contain any of the following: / (slash), '(single quote), "(double quote) and @ (at sign).
faces_rds_username         = "faces"
faces_rds_password         = "mydbpassword"
faces_rds_backup_retention = 14

# Faces - RDS Snapshot to recover from.  After initial deployment this should be set to `faces_rds_snapshot = "final"`
faces_rds_snapshot = ""

# Elasticsearch create linked service role.  If the role already exists set to false.
elasticsearch_create_service_role = false

# AWS Rekognition Custom Labels Configuration. A single inference unit represents 1 hour of model use.
# A single inference unit can support up to 5 transactions per second (TPS).
# Use a higher number to increase the TPS throughput of your model.
# You are charged for the number of inference units that you use.
aws_cust_labels_inference_units = "1"

# (Optional) Google Maps - for plotting geocoded results on a map in the UI
google_maps_key = ""

# (Optional) Logograb (Visua) API Key.
logograb_key = ""

# (Optional) Segment.com Analytics Write Key. Set to an empty string to disable analytics.
segment_write_key = ""

# (Optional) s3subscriber_priority - The priority to assign harvest jobs being scheduled from s3 ObjectCreated notifications.
#                                    Valid values are 1 through 10 (1=highest priority).
#                                    If not set, uses the platform default priority level (5).
# sqs_s3notifications_arn - The ARN of the SQS queue that the s3 ObjectCreated notifications will be read from.
# sqs_s3notifications - The https endpoint of the SQS queue that the s3 ObjectCreated notifications will be read from.
# https://github.com/graymeta/terraform12-aws-platform/blob/master/docs/s3notifications-setup.md
s3subscriber_priority   = 2
sqs_s3notifications_arn = ""
sqs_s3notifications     = ""

# (Optional) Harvest complete fields
# A comma-delimited list of names of any keys from the Stow Metedata or Tags to include in the harvest complete notifications.
# https://api.graymeta.com/040__Misc/Harvest_Complete_Notifications.html
harvest_complete_stow_fields = ""

# (Optional) Graymeta ML Services
mlservices_endpoint = ""

# (Optional) Graymeta Faces Extractor
faces_endpoint = ""
faces_user     = ""
faces_password = ""

# (Optional) Celeberty detection
gm_celeb_detection_enabled        = false
gm_celeb_detection_interval       = "5m"
gm_celeb_detection_min_confidence = "0.6"
gm_celeb_detection_provider       = "gmceleb"

# (Optional) OAuth-storage
# https://github.com/graymeta/terraform12-aws-platform/blob/master/docs/oauth-storage.md
box_com_client_id        = ""
box_com_secret_key       = ""
dropbox_app_key          = ""
dropbox_app_secret       = ""
dropbox_teams_app_key    = ""
dropbox_teams_app_secret = ""
onedrive_client_id       = ""
onedrive_client_secret   = ""
sharepoint_client_id     = ""
sharepoint_client_secret = ""

# (Optional) SAML Configuration
# https://github.com/graymeta/terraform12-aws-platform/blob/master/docs/saml.md
saml_attr_email       = "email"
saml_attr_firstname   = "firstname"
saml_attr_lastname    = "lastname"
saml_attr_uid         = "uid"
saml_cert             = ""
saml_idp_metadata_url = ""
saml_key              = ""
