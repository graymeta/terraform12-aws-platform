# module "mlservices_alb" {
#   # source = "./modules/loadbalancers/mlservices"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/loadbalancers/mlservices?ref=Support-No-Proxy"


#   platform_instance_id = var.platform_instance_id
#   mlservices_alb_nsg   = module.nsg.mlservices_alb_nsg
#   subnets = [
#     module.network.mlservices_subnet_id_1,
#     module.network.mlservices_subnet_id_2
#   ]
# }

# module "mlservices_iam" {
#   # source = "./modules/iam/mlservices"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/iam/mlservices?ref=Support-No-Proxy"

#   platform_instance_id = var.platform_instance_id
# }

# ###########################################
# # MLServices Faces
# module "rds_faces" {
#   # source = "./modules/rds/faces"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/rds/faces?ref=Support-No-Proxy"

#   apply_immediately         = true
#   instance_count            = var.faces_rds_instance_count
#   platform_instance_id      = var.platform_instance_id
#   rds_asg_target_cpu        = 80
#   rds_asg_scalein_cooldown  = 300
#   rds_asg_scaleout_cooldown = 300
#   rds_asg_max_capacity      = var.faces_rds_max_capacity
#   rds_backup_retention      = var.faces_rds_backup_retention
#   rds_backup_window         = "03:00-04:00"
#   rds_database_name         = "faces"
#   rds_instance_size         = var.faces_rds_instance_size
#   rds_kms_key_id            = ""
#   rds_nsg                   = module.nsg.rds_faces_nsg
#   rds_password              = var.faces_rds_password
#   rds_snapshot              = var.faces_rds_snapshot
#   rds_storage_encrypted     = true
#   rds_subnet_group_name     = module.network.rds_faces_subnet_group_name
#   rds_username              = var.faces_rds_username
#   rds_version               = "11.7"
# }

# module "mlservices_faces" {
#   # source = "./modules/mlservices/faces"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/faces?ref=Support-No-Proxy"

#   instance_type                   = var.faces_instance_type
#   key_name                        = var.key_name
#   max_cluster_size                = var.faces_max_cluster_size
#   min_cluster_size                = var.audio_min_cluster_size
#   mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
#   mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
#   mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
#   mlservices_nsg                  = module.nsg.mlservices_nsg
#   mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
#   mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
#   platform_instance_id            = var.platform_instance_id
#   proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
#   rds_database_name               = module.rds_faces.rds_database_name
#   rds_db_password                 = var.faces_rds_password
#   rds_db_username                 = var.faces_rds_username
#   rds_endpoint                    = module.rds_faces.rds_endpoint
#   rds_ro_endpoint                 = module.rds_faces.rds_ro_endpoint
#   target_group_mlservices_arn     = module.mlservices_alb.target_group_faces_arn
#   user_init                       = ""
#   volume_size                     = 100
# }

# ###########################################
# # MLServices Audio
# module "mlservices_audio" {
#   # source = "./modules/mlservices/audio"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/audio?ref=Support-No-Proxy"

#   instance_type                   = var.audio_instance_type
#   key_name                        = var.key_name
#   max_cluster_size                = var.audio_max_cluster_size
#   min_cluster_size                = var.audio_min_cluster_size
#   mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
#   mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
#   mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
#   mlservices_nsg                  = module.nsg.mlservices_nsg
#   mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
#   mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
#   platform_instance_id            = var.platform_instance_id
#   proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
#   target_group_mlservices_arn     = module.mlservices_alb.target_group_audio_arn
#   user_init                       = ""
#   volume_size                     = 50
# }

# output "mlservices_audio" {
#   value = module.mlservices_audio.endpoint
# }

# ###########################################
# # MLServices NLD
# module "mlservices_nld" {
#   # source = "./modules/mlservices/nld"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/nld?ref=Support-No-Proxy"

#   instance_type                   = var.nld_instance_type
#   key_name                        = var.key_name
#   max_cluster_size                = var.nld_max_cluster_size
#   min_cluster_size                = var.nld_min_cluster_size
#   mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
#   mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
#   mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
#   mlservices_nsg                  = module.nsg.mlservices_nsg
#   mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
#   mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
#   platform_instance_id            = var.platform_instance_id
#   proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
#   target_group_mlservices_arn     = module.mlservices_alb.target_group_nld_arn
#   user_init                       = ""
#   volume_size                     = 50
# }

# output "mlservices_nld" {
#   value = module.mlservices_nld.endpoint
# }

# ###########################################
# # MLServices NLP
# module "mlservices_nlp" {
#   # source = "./modules/mlservices/nlp"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/nlp?ref=Support-No-Proxy"

#   instance_type                   = var.nlp_instance_type
#   key_name                        = var.key_name
#   max_cluster_size                = var.nlp_max_cluster_size
#   min_cluster_size                = var.nlp_min_cluster_size
#   mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
#   mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
#   mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
#   mlservices_nsg                  = module.nsg.mlservices_nsg
#   mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
#   mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
#   platform_instance_id            = var.platform_instance_id
#   proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
#   target_group_mlservices_arn     = module.mlservices_alb.target_group_nlp_arn
#   user_init                       = ""
#   volume_size                     = 50
# }

# output "mlservices_nlp" {
#   value = module.mlservices_nlp.endpoint
# }

# ###########################################
# # MLServices Object
# module "mlservices_object" {
#   # source = "./modules/mlservices/object"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/object?ref=Support-No-Proxy"

#   instance_type                   = var.object_instance_type
#   key_name                        = var.key_name
#   max_cluster_size                = var.object_max_cluster_size
#   min_cluster_size                = var.object_min_cluster_size
#   mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
#   mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
#   mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
#   mlservices_nsg                  = module.nsg.mlservices_nsg
#   mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
#   mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
#   platform_instance_id            = var.platform_instance_id
#   proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
#   target_group_mlservices_arn     = module.mlservices_alb.target_group_object_arn
#   user_init                       = ""
#   volume_size                     = 50
# }

# output "mlservices_object" {
#   value = module.mlservices_object.endpoint
# }

# ###########################################
# # MLServices Tcues
# module "mlservices_tcues" {
#   # source = "./modules/mlservices/tcues"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/tcues?ref=Support-No-Proxy"

#   instance_type                   = var.tcues_instance_type
#   key_name                        = var.key_name
#   max_cluster_size                = var.tcues_max_cluster_size
#   min_cluster_size                = var.tcues_min_cluster_size
#   mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
#   mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
#   mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
#   mlservices_nsg                  = module.nsg.mlservices_nsg
#   mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
#   mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
#   platform_instance_id            = var.platform_instance_id
#   proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
#   target_group_mlservices_arn     = module.mlservices_alb.target_group_tcues_arn
#   user_init                       = ""
#   volume_size                     = 50
# }

# output "mlservices_tcues" {
#   value = module.mlservices_tcues.endpoint
# }

# ##########################################
# # MLServices VSSOCCER
# module "mlservices_vssoccer" {
#   # source = "./modules/mlservices/vssoccer"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/vssoccer?ref=Support-No-Proxy"

#   instance_type                   = var.vssoccer_instance_type
#   key_name                        = var.key_name
#   max_cluster_size                = var.vssoccer_max_cluster_size
#   min_cluster_size                = var.vssoccer_min_cluster_size
#   mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
#   mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
#   mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
#   mlservices_nsg                  = module.nsg.mlservices_nsg
#   mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
#   mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
#   platform_instance_id            = var.platform_instance_id
#   proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
#   target_group_mlservices_arn     = module.mlservices_alb.target_group_vssoccer_arn
#   user_init                       = ""
#   volume_size                     = 50
# }

# output "mlservices_vssoccer" {
#   value = module.mlservices_vssoccer.endpoint
# }
