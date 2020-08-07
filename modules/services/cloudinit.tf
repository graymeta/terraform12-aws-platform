data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.userdata.rendered
  }

  part {
    content_type = "text/cloud-config"
    content      = var.user_init
    merge_type   = "list(append)+dict(recurse_array)+str()"
  }
}

data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")

  vars = {
    account_lockout_attempts          = var.account_lockout_attempts
    account_lockout_interval          = var.account_lockout_interval
    account_lockout_period            = var.account_lockout_period
    custom_labels_s3_bucket_arn       = var.custom_labels_s3_bucket_arn
    aws_cust_labels_inference_units   = var.aws_cust_labels_inference_units
    bcrypt_cost                       = var.bcrypt_cost
    box_com_client_id                 = var.box_com_client_id
    box_com_secret_key                = var.box_com_secret_key
    client_secret_fe                  = var.client_secret_fe
    client_secret_internal            = var.client_secret_internal
    cw_prefix                         = "GrayMetaPlatform-${var.platform_instance_id}"
    cw_dest_bucket                    = var.cw_dest_bucket
    db_endpoint                       = var.db_endpoint
    db_password                       = var.db_password
    db_username                       = var.db_username
    dns_name                          = var.dns_name
    dropbox_app_key                   = var.dropbox_app_key
    dropbox_app_secret                = var.dropbox_app_secret
    dropbox_teams_app_key             = var.dropbox_teams_app_key
    dropbox_teams_app_secret          = var.dropbox_teams_app_secret
    ecs_cluster                       = var.ecs_cluster
    ecs_cpu_reservation               = var.ecs_cpu_reservation
    ecs_log_group                     = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
    ecs_memory_hard_reservation       = var.ecs_memory_hard_reservation
    ecs_memory_soft_reservation       = var.ecs_memory_soft_reservation
    elasticache_services              = var.elasticache_services
    elasticsearch_endpoint            = var.elasticsearch_endpoint
    encrypted_config_blob             = var.encrypted_config_blob
    encryption_key                    = var.encryption_key
    faces_endpoint                    = var.faces_endpoint
    file_api_s3_bucket_arn            = var.file_api_s3_bucket_arn
    from_addr                         = var.notifications_from_addr
    from_region                       = var.notifications_region
    gm_celeb_detection_enabled        = var.gm_celeb_detection_enabled
    gm_celeb_detection_interval       = var.gm_celeb_detection_interval
    gm_celeb_detection_min_confidence = var.gm_celeb_detection_min_confidence
    gm_celeb_detection_provider       = var.gm_celeb_detection_provider
    gm_env                            = "${var.customer}-${var.platform_instance_id}"
    gm_es_bulk_size                   = var.gm_es_bulk_size
    gm_es_bulk_workers                = var.gm_es_bulk_workers
    gm_es_replicas                    = var.gm_es_replicas
    gm_es_shards                      = var.gm_es_shards
    gm_jwt_expiration_time            = var.gm_jwt_expiration_time
    gm_license_key                    = var.gm_license_key
    gm_scheduled_max_items            = var.gm_scheduled_max_items
    gm_scheduled_min_bytes            = var.gm_scheduled_min_bytes
    gm_scheduled_wait_duration        = var.gm_scheduled_wait_duration
    gm_threshold_to_harvest           = var.gm_threshold_to_harvest
    gm_usage_prefix                   = "${var.customer}-${var.platform_instance_id}"
    gm_walkd_max_item_concurrency     = var.gm_walkd_max_item_concurrency
    gm_walkd_redis_max_active         = var.gm_walkd_redis_max_active
    google_maps_key                   = var.google_maps_key
    harvest_complete_stow_fields      = var.harvest_complete_stow_fields
    harvest_polling_time              = var.harvest_polling_time
    indexer_concurrency               = var.indexer_concurrency
    item_disable_transaction          = var.item_disable_transaction
    jwt_key                           = var.jwt_key
    logograb_key                      = var.logograb_key
    mlservices_endpoint               = var.mlservices_endpoint
    oauthconnect_encryption_key       = var.oauthconnect_encryption_key
    onedrive_client_id                = var.onedrive_client_id
    onedrive_client_secret            = var.onedrive_client_secret
    password_min_length               = var.password_min_length
    proxy_endpoint                    = var.proxy_endpoint
    region                            = var.region
    rollbar_token                     = var.rollbar_token
    s3subscriber_priority             = var.s3subscriber_priority
    saml_attr_email                   = var.saml_attr_email
    saml_attr_firstname               = var.saml_attr_firstname
    saml_attr_lastname                = var.saml_attr_lastname
    saml_attr_uid                     = var.saml_attr_uid
    saml_cert                         = var.saml_cert
    saml_idp_metadata_url             = var.saml_idp_metadata_url
    saml_key                          = var.saml_key
    segment_write_key                 = var.segment_write_key
    services_log_group                = "GrayMetaPlatform-${var.platform_instance_id}-Services"
    sharepoint_client_id              = var.sharepoint_client_id
    sharepoint_client_secret          = var.sharepoint_client_secret
    sns_topic_arn_harvest_complete    = aws_sns_topic.harvest_complete.arn
    sqs_activity                      = var.sqs_activity
    sqs_index                         = var.sqs_index
    sqs_itemcleanup                   = var.sqs_itemcleanup
    sqs_notifications                 = var.sqs_s3notifications
    sqs_stage                         = "${var.sqs_stage01},${var.sqs_stage02},${var.sqs_stage03},${var.sqs_stage04},${var.sqs_stage05},${var.sqs_stage06},${var.sqs_stage07},${var.sqs_stage08},${var.sqs_stage09},${var.sqs_stage10}"
    sqs_walk                          = var.sqs_walk
    statsd_host                       = var.statsd_host
    temp_s3_bucket_arn                = var.temp_s3_bucket_arn
    usage_s3_bucket_arn               = var.usage_s3_bucket_arn
    walkd_item_batch_size             = var.walkd_item_batch_size
  }
}