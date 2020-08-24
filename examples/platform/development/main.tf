provider "aws" {
  region  = var.region
  profile = var.profile
}

data "aws_region" "current" {}

module "servicesiam" {
  source = "github.com/graymeta/terraform-aws-platform//modules/servicesiam?ref=v0.2.0"

  platform_instance_id = "${var.platform_instance_id}"
}

module "amis" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/amis?ref=master"
}

module "network" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/network/vpc?ref=master"

  az1                         = var.az1
  az2                         = var.az2
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
  cidr_vpc                    = "10.0.0.0/16"
  platform_instance_id        = var.platform_instance_id
}

module "nsg" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/security_groups?ref=master"

  ecs_subnet_id_1        = module.network.ecs_subnet_id_1
  ecs_subnet_id_2        = module.network.ecs_subnet_id_2
  mlservices_subnet_id_1 = module.network.mlservices_subnet_id_1
  mlservices_subnet_id_2 = module.network.mlservices_subnet_id_2
  platform_access_cidrs  = var.platform_access_cidrs
  platform_instance_id   = var.platform_instance_id
  proxy_subnet_id_1      = module.network.proxy_subnet_id_1
  proxy_subnet_id_2      = module.network.proxy_subnet_id_2
  services_subnet_id_1   = module.network.services_subnet_id_1
  services_subnet_id_2   = module.network.services_subnet_id_2
  ssh_cidr_blocks        = var.ssh_cidr_blocks
  vpc_id                 = module.network.vpc_id
}

module "proxy_iam" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/iam/proxy?ref=master"

  platform_instance_id = var.platform_instance_id
}

module "proxy_loadbalancer" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/loadbalancers/proxy?ref=master"

  platform_instance_id = var.platform_instance_id
  subnets = [
    module.network.proxy_subnet_id_1,
    module.network.proxy_subnet_id_2
  ]
}

module "proxy_asg" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/proxy?ref=master"

  dns_name                            = var.dns_name
  key_name                            = var.key_name
  platform_instance_id                = var.platform_instance_id
  proxy_ami_id                        = lookup(module.amis.proxy_amis, data.aws_region.current.name)
  proxy_iam_instance_profile          = module.proxy_iam.proxy_iam_instance_profile
  proxy_instance_type                 = "m5.large"
  proxy_max_cluster_size              = 2
  proxy_min_cluster_size              = 1
  proxy_nsg                           = module.nsg.proxy_nsg
  proxy_scale_down_evaluation_periods = 4
  proxy_scale_down_period             = 300
  proxy_scale_down_thres              = "250000000"
  proxy_scale_up_evaluation_periods   = 2
  proxy_scale_up_period               = 120
  proxy_scale_up_thres                = "875000000"
  proxy_subnet_id_1                   = module.network.proxy_subnet_id_1
  proxy_subnet_id_2                   = module.network.proxy_subnet_id_1
  proxy_user_init                     = ""
  target_group_3128_arn               = module.proxy_loadbalancer.target_group_3128_arn
}

module "proxy_network" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/network/proxy?ref=master"

  default_route_table_id = module.network.default_route_table_id
  platform_instance_id   = var.platform_instance_id
  proxy_subnet_id_1      = module.network.proxy_subnet_id_1
  proxy_subnet_id_2      = module.network.proxy_subnet_id_2
  public_subnet_id_1     = module.network.public_subnet_id_1
  public_subnet_id_2     = module.network.public_subnet_id_2
  vpc_id                 = module.network.vpc_id
}

module "cloudwatch_logs" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/cloudwatch?ref=master"

  log_retention        = var.log_retention
  platform_instance_id = var.platform_instance_id
}

module "queues" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/queues?ref=master"

  platform_instance_id = var.platform_instance_id
}

module "elasticache" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/elasticache?ref=master"

  elasticache_security_group    = module.nsg.elasticache_nsg
  elasticache_subnet_group_name = module.network.elasticache_subnet_group_name
  instance_type                 = "cache.m5.large"
  platform_instance_id          = var.platform_instance_id
}

module "rds" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/rds/services?ref=master"

  apply_immediately     = true
  instance_count        = 1
  platform_instance_id  = var.platform_instance_id
  rds_backup_retention  = 1
  rds_backup_window     = "03:00-04:00"
  rds_database_name     = "graymeta"
  rds_instance_size     = "db.r5.large"
  rds_kms_key_id        = ""
  rds_nsg               = module.nsg.rds_nsg
  rds_password          = var.rds_password
  rds_snapshot          = var.rds_snapshot
  rds_storage_encrypted = true
  rds_subnet_group_name = module.network.rds_subnet_group_name
  rds_username          = var.rds_username
  rds_version           = "11.7"
}

module "elasticsearch" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/elasticsearch?ref=master"

  create_iam_service_linked_role = var.elasticsearch_create_service_role
  dedicated_master_count         = 0
  dedicated_master_enabled       = false
  dedicated_master_type          = "m5.large.elasticsearch"
  elasticsearch_security_group   = module.nsg.elasticsearch_nsg
  instance_count                 = 4
  instance_type                  = "m5.large.elasticsearch"
  platform_instance_id           = var.platform_instance_id
  subnet_id_1                    = module.network.elasticsearch_subnet_id_1
  subnet_id_2                    = module.network.elasticsearch_subnet_id_2
  volume_size                    = 50
}

module "ecs_iam" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/iam/ecs?ref=master"

  platform_instance_id = var.platform_instance_id
  temp_bucket          = var.temp_bucket
}

module "ecs" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/ecs?ref=master"

  ecs_ami_id               = lookup(module.amis.ecs_amis, data.aws_region.current.name)
  ecs_iam_instance_profile = module.ecs_iam.ecs_iam_instance_profile
  ecs_instance_type        = "m5.large"
  ecs_max_cluster_size     = 4
  ecs_min_cluster_size     = 1
  ecs_nsg                  = module.nsg.ecs_nsg
  ecs_subnet_id_1          = module.network.ecs_subnet_id_1
  ecs_subnet_id_2          = module.network.ecs_subnet_id_2
  ecs_user_init            = ""
  ecs_volume_size          = 50
  key_name                 = var.key_name
  platform_instance_id     = var.platform_instance_id
  proxy_endpoint           = module.proxy_loadbalancer.proxy_endpoint
}

resource "aws_sns_topic" "harvest_complete" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-HarvestComplete"
}

module "services_iam" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/iam/services?ref=master"

  custom_labels_bucket     = var.custom_labels_bucket
  file_api_bucket          = var.file_api_bucket
  notifications_from_addr  = var.notifications_from_addr
  platform_instance_id     = var.platform_instance_id
  services_role_name       = module.servicesiam.services_iam_role_name
  sns_harvest_complete_arn = aws_sns_topic.harvest_complete.arn
  sqs_activity_arn         = module.queues.activity_arn
  sqs_index_arn            = module.queues.index_arn
  sqs_itemcleanup_arn      = module.queues.itemcleanup_arn
  sqs_s3notifications_arn  = var.sqs_s3notifications_arn
  sqs_stage01_arn          = module.queues.stage01_arn
  sqs_stage02_arn          = module.queues.stage02_arn
  sqs_stage03_arn          = module.queues.stage03_arn
  sqs_stage04_arn          = module.queues.stage04_arn
  sqs_stage05_arn          = module.queues.stage05_arn
  sqs_stage06_arn          = module.queues.stage06_arn
  sqs_stage07_arn          = module.queues.stage07_arn
  sqs_stage08_arn          = module.queues.stage08_arn
  sqs_stage09_arn          = module.queues.stage09_arn
  sqs_stage10_arn          = module.queues.stage10_arn
  sqs_walk_arn             = module.queues.walk_arn
  temp_bucket              = var.temp_bucket
  usage_bucket             = var.usage_bucket
}

module "services_alb" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/loadbalancers/services?ref=master"

  platform_instance_id = var.platform_instance_id
  services_alb_nsg     = module.nsg.services_alb_nsg
  ssl_certificate_arn  = var.ssl_certificate_arn
  subnets = [
    module.network.public_subnet_id_1,
    module.network.public_subnet_id_2
  ]
}

module "services" {
  source = "github.com/graymeta/terraform12-aws-platform//modules/services?ref=master"

  account_lockout_attempts          = 5
  account_lockout_interval          = "10m"
  account_lockout_period            = "10m"
  aws_cust_labels_inference_units   = 1
  bcrypt_cost                       = 14
  box_com_client_id                 = ""
  box_com_secret_key                = ""
  client_secret_fe                  = var.client_secret_fe
  client_secret_internal            = var.client_secret_internal
  custom_labels_bucket              = var.custom_labels_bucket
  customer                          = var.customer
  cw_dest_bucket                    = ""
  dns_name                          = var.dns_name
  dropbox_app_key                   = ""
  dropbox_app_secret                = ""
  dropbox_teams_app_key             = ""
  dropbox_teams_app_secret          = ""
  ecs_cluster                       = module.ecs.ecs_cluster
  ecs_cpu_reservation               = 1024
  ecs_memory_hard_reservation       = 4000
  ecs_memory_soft_reservation       = 3000
  elasticsearch_endpoint            = module.elasticsearch.elasticsearch_endpoint
  encrypted_config_blob             = var.encrypted_config_blob
  encryption_key                    = var.encryption_key
  faces_endpoint                    = var.faces_endpoint
  faces_user                        = var.faces_user
  faces_password                    = var.faces_password
  file_api_bucket                   = var.file_api_bucket
  gm_celeb_detection_enabled        = var.gm_celeb_detection_enabled
  gm_celeb_detection_interval       = var.gm_celeb_detection_interval
  gm_celeb_detection_min_confidence = var.gm_celeb_detection_min_confidence
  gm_celeb_detection_provider       = var.gm_celeb_detection_provider
  gm_es_bulk_size                   = 20000000
  gm_es_bulk_workers                = 2
  gm_es_replicas                    = 1
  gm_es_shards                      = 5
  gm_jwt_expiration_time            = "168h"
  gm_license_key                    = var.gm_license_key
  gm_scheduled_max_items            = 100
  gm_scheduled_min_bytes            = 1073741824
  gm_scheduled_wait_duration        = "20s"
  gm_threshold_to_harvest           = ""
  gm_walkd_max_item_concurrency     = 600
  gm_walkd_redis_max_active         = 1200
  google_maps_key                   = var.google_maps_key
  harvest_complete_stow_fields      = var.harvest_complete_stow_fields
  harvest_polling_time              = "6h"
  indexer_concurrency               = 1
  item_disable_transaction          = false
  jwt_key                           = var.jwt_key
  key_name                          = var.key_name
  logograb_key                      = var.logograb_key
  mlservices_endpoint               = var.mlservices_endpoint
  notifications_from_addr           = var.notifications_from_addr
  notifications_region              = var.notifications_region
  oauthconnect_encryption_key       = var.oauthconnect_encryption_key
  onedrive_client_id                = var.onedrive_client_id
  onedrive_client_secret            = var.onedrive_client_secret
  password_min_length               = 8
  platform_instance_id              = var.platform_instance_id
  proxy_endpoint                    = module.proxy_loadbalancer.proxy_endpoint
  rds_database_name                 = module.rds.rds_database_name
  rds_endpoint                      = module.rds.rds_endpoint
  rds_password                      = var.rds_password
  rds_username                      = var.rds_username
  redis_endpoint                    = module.elasticache.redis_endpoint
  rollbar_token                     = ""
  s3subscriber_priority             = var.s3subscriber_priority
  saml_attr_email                   = var.saml_attr_email
  saml_attr_firstname               = var.saml_attr_firstname
  saml_attr_lastname                = var.saml_attr_lastname
  saml_attr_uid                     = var.saml_attr_uid
  saml_cert                         = var.saml_cert
  saml_idp_metadata_url             = var.saml_idp_metadata_url
  saml_key                          = var.saml_key
  segment_write_key                 = var.segment_write_key
  services_ami_id                   = lookup(module.amis.services_amis, data.aws_region.current.name)
  services_iam_instance_profile     = module.services_iam.services_iam_instance_profile
  services_instance_type            = "m5.large"
  services_max_cluster_size         = 2
  services_min_cluster_size         = 1
  services_nsg                      = module.nsg.services_nsg
  services_scale_down_threshold_cpu = 50
  services_scale_up_threshold_cpu   = 70
  services_subnet_id_1              = module.network.services_subnet_id_1
  services_subnet_id_2              = module.network.services_subnet_id_2
  sharepoint_client_id              = var.sharepoint_client_id
  sharepoint_client_secret          = var.sharepoint_client_secret
  sqs_activity                      = module.queues.activity
  sqs_index                         = module.queues.index
  sqs_itemcleanup                   = module.queues.itemcleanup
  sqs_s3notifications               = var.sqs_s3notifications
  sqs_stage01                       = module.queues.stage01
  sqs_stage02                       = module.queues.stage02
  sqs_stage03                       = module.queues.stage03
  sqs_stage04                       = module.queues.stage04
  sqs_stage05                       = module.queues.stage05
  sqs_stage06                       = module.queues.stage06
  sqs_stage07                       = module.queues.stage07
  sqs_stage08                       = module.queues.stage08
  sqs_stage09                       = module.queues.stage09
  sqs_stage10                       = module.queues.stage10
  sqs_walk                          = module.queues.walk
  target_group_7000_arn             = module.services_alb.target_group_7000_arn
  target_group_7009_arn             = module.services_alb.target_group_7009_arn
  temp_bucket                       = var.temp_bucket
  usage_bucket                      = var.usage_bucket
  user_init                         = ""
  walkd_item_batch_size             = 300
}

output "GrayMetaPlatformEndpoint" {
  value = "${module.services_alb.services_endpoint}"
}
