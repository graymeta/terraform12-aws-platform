az1 = "us-east-1a"
az2 = "us-east-1b"

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


platform_instance_id  = "development"
customer              = "acme"
platform_access_cidrs = "0.0.0.0/0"
ssh_cidr_blocks       = "10.0.0.0/16"

dns_name = "acme.cust.graymeta.com"
key_name = "sysadmin"

notifications_from_addr = ""
notifications_region    = ""
ssl_certificate_arn     = ""

gm_license_key = ""


log_retention = 2

rds_username = "mydbuser"
rds_password = "mydbpassword"
rds_snapshot = ""

elasticsearch_create_service_role = false
custom_labels_bucket              = ""
file_api_bucket                   = ""
temp_bucket                       = ""
usage_bucket                      = ""


client_secret_fe            = "012345678901234567890123456789ab"
client_secret_internal      = "012345678901234567890123456789ab"
encryption_key              = "012345678901234567890123456789ab"
jwt_key                     = "012345678901234567890123456789ab"
oauthconnect_encryption_key = "012345678901234567890123456789ab"
encrypted_config_blob       = ""

# AWS Rekognition Custom Labels Configuration
aws_cust_labels_inference_units = "1"

# (Optional) Google maps - for plotting geocoded results on a map in the UI
google_maps_key = ""

# (Optional) logograb
logograb_key = ""

# (Optional) Segment.com Analytics Write Key. Set to an empty string to disable analytics.
segment_write_key = ""

# (Optional) s3 notification
s3subscriber_priority   = 2
sqs_s3notifications_arn = ""
sqs_s3notifications     = ""

# (Optional) Harvest complete fields
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
saml_attr_email       = "email"
saml_attr_firstname   = "firstname"
saml_attr_lastname    = "lastname"
saml_attr_uid         = "uid"
saml_cert             = ""
saml_idp_metadata_url = ""
saml_key              = ""

