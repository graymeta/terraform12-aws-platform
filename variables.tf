variable "audio_instance_type" { type = string }
variable "audio_max_cluster_size" { type = number }
variable "audio_min_cluster_size" { type = number }
variable "aws_cust_labels_inference_units" {
  type        = string
  description = "A single inference unit represents 1 hour of model use. A single inference unit can support up to 5 transactions per second (TPS). Use a higher number to increase the TPS throughput of your model. You are charged for the number of inference units that you use."
}
variable "az1" {
  type        = string
  description = "Availability Zone 1."
}
variable "az2" {
  type        = string
  description = "Availability Zone 2."
}
variable "box_com_client_id" {
  type        = string
  description = "Box Oauth 2.0 Credentials Client ID."
}
variable "box_com_secret_key" {
  type        = string
  description = "Box Oauth 2.0 Credentials Client Secret."
}
variable "cidr_subnet_ecs_1" {
  type        = string
  description = "The CIDR block to use for the ecs subnet"
}
variable "cidr_subnet_ecs_2" {
  type        = string
  description = "The CIDR block to use for the ecs subnet"
}
variable "cidr_subnet_elasticsearch_1" {
  type        = string
  description = "The CIDR block to use for the elasticsearch subnet"
}
variable "cidr_subnet_elasticsearch_2" {
  type        = string
  description = "The CIDR block to use for the elasticsearch subnet"
}
variable "cidr_subnet_mlservices_1" {
  type        = string
  description = "The CIDR block to use for the mlservices subnet"
}
variable "cidr_subnet_mlservices_2" {
  type        = string
  description = "The CIDR block to use for the mlservices subnet"
}
variable "cidr_subnet_proxy_1" {
  type        = string
  description = "The CIDR block to use for the proxy subnet"
}
variable "cidr_subnet_proxy_2" {
  type        = string
  description = "The CIDR block to use for the proxy subnet"
}
variable "cidr_subnet_public_1" {
  type        = string
  description = "The CIDR block to use for the public subnet"
}
variable "cidr_subnet_public_2" {
  type        = string
  description = "The CIDR block to use for the public subnet"
}
variable "cidr_subnet_rds_1" {
  type        = string
  description = "The CIDR block to use for the rds subnet"
}
variable "cidr_subnet_rds_2" {
  type        = string
  description = "The CIDR block to use for the rds subnet"
}
variable "cidr_subnet_services_1" {
  type        = string
  description = "The CIDR block to use for the services subnet"
}
variable "cidr_subnet_services_2" {
  type        = string
  description = "The CIDR block to use for the services subnet"
}
variable "cidr_vpc" { type = string }
variable "client_secret_fe" { type = string }
variable "client_secret_internal" { type = string }
variable "customer" {
  type        = string
  description = "Customer short name."
}
variable "custom_labels_bucket" {
  type        = string
  description = "Buket for AWS Custom Labels service."
}
variable "dns_name" { type = string }
variable "dropbox_app_key" {
  type        = string
  description = "Dropbox App key"
}
variable "dropbox_app_secret" {
  type        = string
  description = "Dropbox Application secret"
}
variable "dropbox_teams_app_key" {
  type        = string
  description = "Dropbox App key"
}
variable "dropbox_teams_app_secret" {
  type        = string
  description = "Dropbox Application secret"
}
variable "ecs_instance_type" { type = string }
variable "ecs_max_cluster_size" { type = number }
variable "ecs_min_cluster_size" { type = number }
variable "ecs_volume_size" { type = number }
variable "elasticache_instance_type" { type = string }
variable "elasticsearch_create_service_role" { type = bool }
variable "elasticsearch_dedicated_master_enabled" { type = bool }
variable "elasticsearch_dedicated_master_count" { type = number }
variable "elasticsearch_dedicated_master_type" { type = string }
variable "elasticsearch_instance_count" { type = number }
variable "elasticsearch_instance_type" { type = string }
variable "elasticsearch_volume_size" { type = number }
variable "encrypted_config_blob" { type = string }
variable "encryption_key" { type = string }
variable "faces_endpoint" {
  type    = string
  default = ""
}
variable "faces_instance_type" { type = string }
variable "faces_max_cluster_size" { type = number }
variable "faces_min_cluster_size" { type = number }
variable "faces_password" {
  type    = string
  default = ""
}
variable "faces_rds_instance_count" { type = number }
variable "faces_rds_max_capacity" { type = number }
variable "faces_rds_backup_retention" { type = number }
variable "faces_rds_instance_size" { type = string }
variable "faces_rds_password" { type = string }
variable "faces_rds_snapshot" { type = string }
variable "faces_user" {
  type    = string
  default = ""
}
variable "faces_rds_username" { type = string }
variable "file_api_bucket" {
  type        = string
  description = "S3 bucket name to store thumbnails, transcoded video and audio preview files, and metadata files."
}
variable "gm_celeb_detection_enabled" { type = string }
variable "gm_celeb_detection_interval" { type = string }
variable "gm_celeb_detection_min_confidence" { type = string }
variable "gm_celeb_detection_provider" { type = string }
variable "gm_license_key" {
  type        = string
  description = "License key provided by GrayMeta."
}
variable "google_maps_key" {
  type        = string
  description = "Google Maps API key."
}
variable "harvest_complete_stow_fields" { type = string }
variable "jwt_key" { type = string }
variable "key_name" { type = string }
variable "log_retention" {
  type        = number
  description = "Log retention in days."
}
variable "logograb_key" {
  type        = string
  description = "API key for the Logograb (Visua) service."
}
variable "mlservices_endpoint" {
  type    = string
  default = ""
}
variable "nld_instance_type" { type = string }
variable "nld_max_cluster_size" { type = number }
variable "nld_min_cluster_size" { type = number }
variable "nlp_instance_type" { type = string }
variable "nlp_max_cluster_size" { type = number }
variable "nlp_min_cluster_size" { type = number }
variable "notifications_from_addr" { type = string }
variable "notifications_region" { type = string }
variable "oauthconnect_encryption_key" { type = string }
variable "object_instance_type" { type = string }
variable "object_max_cluster_size" { type = number }
variable "object_min_cluster_size" { type = number }
variable "onedrive_client_id" { type = string }
variable "onedrive_client_secret" { type = string }
variable "platform_access_cidrs" { type = string }
variable "platform_instance_id" { type = string }
variable "proxy_instance_type" { type = string }
variable "proxy_max_cluster_size" { type = number }
variable "proxy_min_cluster_size" { type = number }
variable "proxy_scale_down_thres" { type = number }
variable "proxy_scale_up_thres" { type = number }
variable "profile" { type = string }
variable "rds_backup_retention" { type = number }
variable "rds_instance_size" { type = string }
variable "rds_instance_count" { type = number }
variable "rds_password" { type = string }
variable "rds_snapshot" { type = string }
variable "rds_username" { type = string }
variable "region" { type = string }
variable "s3subscriber_priority" { type = number }
variable "saml_attr_email" { type = string }
variable "saml_attr_firstname" { type = string }
variable "saml_attr_lastname" { type = string }
variable "saml_attr_uid" { type = string }
variable "saml_cert" { type = string }
variable "saml_idp_metadata_url" { type = string }
variable "saml_key" { type = string }
variable "segment_write_key" { type = string }
variable "services_instance_type" { type = string }
variable "services_max_cluster_size" { type = number }
variable "services_min_cluster_size" { type = number }
variable "sharepoint_client_id" { type = string }
variable "sharepoint_client_secret" { type = string }
variable "sqs_s3notifications" { type = string }
variable "sqs_s3notifications_arn" { type = string }
variable "ssh_cidr_blocks" { type = string }
variable "ssl_certificate_arn" { type = string }
variable "tcues_instance_type" { type = string }
variable "tcues_max_cluster_size" { type = number }
variable "tcues_min_cluster_size" { type = number }
variable "temp_bucket" { type = string }
variable "usage_bucket" { type = string }
variable "vssoccer_instance_type" { type = string }
variable "vssoccer_max_cluster_size" { type = number }
variable "vssoccer_min_cluster_size" { type = number }
