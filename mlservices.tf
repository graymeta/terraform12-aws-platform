module "mlservices_alb" {
  # source = "../../modules/loadbalancers/mlservices"
  source = "github.com/graymeta/terraform12-aws-platform//modules/loadbalancers/mlservices?ref=master"


  platform_instance_id = var.platform_instance_id
  mlservices_alb_nsg   = module.nsg.mlservices_alb_nsg
  subnets = [
    module.network.mlservices_subnet_id_1,
    module.network.mlservices_subnet_id_2
  ]
}

module "mlservices_iam" {
  # source = "../../modules/iam/mlservices"
  source = "github.com/graymeta/terraform12-aws-platform//modules/iam/mlservices?ref=master"

  platform_instance_id = var.platform_instance_id
}

###########################################
# MLServices Faces

###########################################
# MLServices Audio
module "mlservices_audio" {
  # source = "../../modules/mlservices/audio"
  source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/audio?ref=master"

  instance_type                   = var.audio_instance_type
  key_name                        = var.key_name
  max_cluster_size                = var.audio_max_cluster_size
  min_cluster_size                = var.audio_min_cluster_size
  mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
  mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
  mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
  mlservices_nsg                  = module.nsg.mlservices_nsg
  mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
  mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
  platform_instance_id            = var.platform_instance_id
  proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
  target_group_mlservices_arn     = module.mlservices_alb.target_group_audio_arn
  user_init                       = ""
  volume_size                     = 50
}

output "mlservices_audio" {
  value = module.mlservices_audio.endpoint
}

# ###########################################
# # MLServices NLD
# module "mlservices_nld" {
#   # source = "../../modules/mlservices/nld"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/nld?ref=master"

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
#   # source = "../../modules/mlservices/nlp"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/nlp?ref=master"

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
#   # source = "../../modules/mlservices/object"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/object?ref=master"

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
#   # source = "../../modules/mlservices/tcues"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/tcues?ref=master"

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
#   # source = "../../modules/mlservices/vssoccer"
#   source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/vssoccer?ref=master"

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
