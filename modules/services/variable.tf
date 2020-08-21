variable "account_lockout_attempts" {
  type    = string
  default = 5
}

variable "account_lockout_interval" {
  type    = string
  default = "10m"
}

variable "account_lockout_period" {
  type    = string
  default = "10m"
}

variable "custom_labels_bucket" {
  type = string
}

variable "aws_cust_labels_inference_units" {
  type    = string
  default = 1
}

variable "bcrypt_cost" {
  type    = string
  default = "14"
}

variable "box_com_client_id" {
  type    = string
  default = ""
}

variable "box_com_secret_key" {
  type    = string
  default = ""
}

variable "client_secret_fe" {
  type    = string
  default = ""
}

variable "client_secret_internal" {
  type    = string
  default = ""
}

variable "customer" {
  type = string
}

variable "cw_dest_bucket" {
  type    = string
  default = ""
}

variable "dns_name" {
  type = string
}

variable "dropbox_app_key" {
  type    = string
  default = ""
}

variable "dropbox_app_secret" {
  type    = string
  default = ""
}

variable "dropbox_teams_app_key" {
  type    = string
  default = ""
}

variable "dropbox_teams_app_secret" {
  type    = string
  default = ""
}

variable "ecs_cluster" {
  type = string
}

variable "ecs_cpu_reservation" {
  type    = string
  default = "1024"
}

variable "ecs_memory_hard_reservation" {
  type    = string
  default = "4000"
}

variable "ecs_memory_soft_reservation" {
  type    = string
  default = "3000"
}

variable "elasticsearch_endpoint" {
  type = string
}

variable "encrypted_config_blob" {
  type    = string
  default = ""
}

variable "encryption_key" {
  type    = string
  default = ""
}

variable "faces_endpoint" {
  type    = string
  default = ""
}

variable "file_api_bucket" {
  type = string
}

variable "gm_celeb_detection_enabled" {
  type    = string
  default = "false"
}

variable "gm_celeb_detection_interval" {
  type    = string
  default = "5m"
}

variable "gm_celeb_detection_min_confidence" {
  type    = string
  default = "0.6"
}

variable "gm_celeb_detection_provider" {
  type    = string
  default = "gmceleb"
}

variable "gm_es_bulk_size" {
  type    = string
  default = "20000000"
}

variable "gm_es_bulk_workers" {
  type    = string
  default = "2"
}

variable "gm_es_replicas" {
  type    = string
  default = "1"
}

variable "gm_es_shards" {
  type    = string
  default = "5"
}

variable "gm_jwt_expiration_time" {
  type    = string
  default = "168h"
}

variable "gm_license_key" {
  type = string
}

variable "gm_scheduled_max_items" {
  type    = string
  default = "100"
}

variable "gm_scheduled_min_bytes" {
  type    = string
  default = "10485760"
}

variable "gm_scheduled_wait_duration" {
  type    = string
  default = "20s"
}

variable "gm_threshold_to_harvest" {
  type    = string
  default = ""
}

variable "gm_walkd_max_item_concurrency" {
  type    = string
  default = "600"
}

variable "gm_walkd_redis_max_active" {
  type    = string
  default = "1200"
}

variable "google_maps_key" {
  type    = string
  default = ""
}

variable "harvest_complete_stow_fields" {
  type    = string
  default = ""
}

variable "harvest_polling_time" {
  type    = string
  default = "6h"
}

variable "indexer_concurrency" {
  type    = string
  default = "1"
}

variable "item_disable_transaction" {
  type    = string
  default = "false"
}

variable "jwt_key" {
  type    = string
  default = ""
}

variable "key_name" {
  type = string
}

variable "logograb_key" {
  type    = string
  default = ""
}

variable "mlservices_endpoint" {
  type    = string
  default = ""
}

variable "notifications_from_addr" {
  type = string
}

variable "notifications_region" {
  type    = string
  default = ""
}

variable "oauthconnect_encryption_key" {
  type = string
}

variable "onedrive_client_id" {
  type    = string
  default = ""
}

variable "onedrive_client_secret" {
  type    = string
  default = ""
}

variable "password_min_length" {
  type    = string
  default = "8"
}

variable "platform_instance_id" {
  type = string
}

variable "proxy_endpoint" {
  type = string
}

variable "rds_endpoint" {
  type = string
}

variable "rds_database_name" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "rds_username" {
  type = string
}

variable "redis_endpoint" {
  type = string
}

variable "rollbar_token" {
  type    = string
  default = ""
}

variable "s3subscriber_priority" {
  type    = string
  default = "0"
}

variable "saml_attr_email" {
  type    = string
  default = "email"
}

variable "saml_attr_firstname" {
  type    = string
  default = "firstname"
}

variable "saml_attr_lastname" {
  type    = string
  default = "lastname"
}

variable "saml_attr_uid" {
  type    = string
  default = "uid"
}

variable "saml_cert" {
  type    = string
  default = ""
}

variable "saml_idp_metadata_url" {
  type    = string
  default = ""
}

variable "saml_key" {
  type    = string
  default = ""
}

variable "segment_write_key" {
  type    = string
  default = ""
}

variable "services_ami_id" {
  type = string
}

variable "services_iam_instance_profile" {
  type = string
}

variable "services_instance_type" {
  type = string
}

variable "services_max_cluster_size" {
  type = string
}

variable "services_min_cluster_size" {
  type = string
}

variable "services_nsg" {
  type = string
}

variable "services_scale_down_threshold_cpu" {
  type    = string
  default = "50"
}

variable "services_scale_up_threshold_cpu" {
  type    = string
  default = "70"
}

variable "services_subnet_id_1" {
  type = string
}

variable "services_subnet_id_2" {
  type = string
}

variable "sharepoint_client_id" {
  type    = string
  default = ""
}

variable "sharepoint_client_secret" {
  type    = string
  default = ""
}

variable "sqs_activity" {
  type = string
}

variable "sqs_index" {
  type = string
}

variable "sqs_itemcleanup" {
  type = string
}

variable "sqs_s3notifications" {
  type = string
}

variable "sqs_stage01" {
  type = string
}

variable "sqs_stage02" {
  type = string
}

variable "sqs_stage03" {
  type = string
}

variable "sqs_stage04" {
  type = string
}

variable "sqs_stage05" {
  type = string
}

variable "sqs_stage06" {
  type = string
}

variable "sqs_stage07" {
  type = string
}

variable "sqs_stage08" {
  type = string
}

variable "sqs_stage09" {
  type = string
}

variable "sqs_stage10" {
  type = string
}

variable "sqs_walk" {
  type = string
}

variable "statsd_host" {
  type    = string
  default = ""
}

variable "target_group_7000_arn" {
  type = string
}

variable "target_group_7009_arn" {
  type = string
}

variable "temp_bucket" {
  type = string
}

variable "usage_bucket" {
  type = string
}

variable "user_init" {
  type    = string
  default = ""
}

variable "walkd_item_batch_size" {
  type    = string
  default = "300"
}
