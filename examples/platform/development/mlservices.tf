module "mlservices_alb" {
  #source = "github.com/graymeta/terraform12-aws-platform//modules/loadbalancers/mlservices?ref=master"
  source = "../../../modules/loadbalancers/mlservices"

  platform_instance_id = var.platform_instance_id
  mlservices_alb_nsg   = module.nsg.mlservices_alb_nsg
  subnets = [
    module.network.mlservices_subnet_id_1,
    module.network.mlservices_subnet_id_2
  ]
}

module "mlservices_iam" {
  #source = "github.com/graymeta/terraform12-aws-platform//modules/iam/mlservices?ref=master"
  source = "../../../modules/iam/mlservices"

  platform_instance_id = var.platform_instance_id
}

###########################################
# MLServices Faces

###########################################
# MLServices Audio
module "mlservices_audio" {
  #source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/audio?ref=master"
  source = "../../../modules/mlservices/audio"

  instance_type                   = "m5.xlarge"
  key_name                        = var.key_name
  max_cluster_size                = 2
  min_cluster_size                = 1
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

###########################################
# MLServices NLD
module "mlservices_nld" {
  #source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/nld?ref=master"
  source = "../../../../terraform12-aws-platform/modules/mlservices/nld"

  instance_type                   = "m5.xlarge"
  key_name                        = var.key_name
  max_cluster_size                = 2
  min_cluster_size                = 1
  mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
  mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
  mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
  mlservices_nsg                  = module.nsg.mlservices_nsg
  mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
  mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
  platform_instance_id            = var.platform_instance_id
  proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
  target_group_mlservices_arn     = module.mlservices_alb.target_group_nld_arn
  user_init                       = ""
  volume_size                     = 50
}

output "mlservices_nld" {
  value = module.mlservices_nld.endpoint
}

###########################################
# MLServices NLP
module "mlservices_nlp" {
  #source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/nlp?ref=master"
  source = "../../../../terraform12-aws-platform/modules/mlservices/nlp"

  instance_type                   = "m5.xlarge"
  key_name                        = var.key_name
  max_cluster_size                = 2
  min_cluster_size                = 1
  mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
  mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
  mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
  mlservices_nsg                  = module.nsg.mlservices_nsg
  mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
  mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
  platform_instance_id            = var.platform_instance_id
  proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
  target_group_mlservices_arn     = module.mlservices_alb.target_group_nlp_arn
  user_init                       = ""
  volume_size                     = 50
}

output "mlservices_nlp" {
  value = module.mlservices_nlp.endpoint
}

###########################################
# MLServices Object
module "mlservices_object" {
  #source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/object?ref=master"
  source = "../../../../terraform12-aws-platform/modules/mlservices/object"

  instance_type                   = "m5.xlarge"
  key_name                        = var.key_name
  max_cluster_size                = 2
  min_cluster_size                = 1
  mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
  mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
  mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
  mlservices_nsg                  = module.nsg.mlservices_nsg
  mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
  mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
  platform_instance_id            = var.platform_instance_id
  proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
  target_group_mlservices_arn     = module.mlservices_alb.target_group_object_arn
  user_init                       = ""
  volume_size                     = 50
}

output "mlservices_object" {
  value = module.mlservices_audio.endpoint
}

###########################################
# MLServices Tcues
module "mlservices_tcues" {
  #source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/tcues?ref=master"
  source = "../../../../terraform12-aws-platform/modules/mlservices/tcues"

  instance_type                   = "m5.xlarge"
  key_name                        = var.key_name
  max_cluster_size                = 2
  min_cluster_size                = 1
  mlservices_alb_dns              = module.mlservices_alb.mlservices_endpoint
  mlservices_ami_id               = lookup(module.amis.mlservices_amis, data.aws_region.current.name)
  mlservices_iam_instance_profile = module.mlservices_iam.mlservices_iam_instance_profile
  mlservices_nsg                  = module.nsg.mlservices_nsg
  mlservices_subnet_id_1          = module.network.mlservices_subnet_id_1
  mlservices_subnet_id_2          = module.network.mlservices_subnet_id_2
  platform_instance_id            = var.platform_instance_id
  proxy_endpoint                  = module.proxy_loadbalancer.proxy_endpoint
  target_group_mlservices_arn     = module.mlservices_alb.target_group_tcues_arn
  user_init                       = ""
  volume_size                     = 50
}

output "mlservices_tcues" {
  value = module.mlservices_tcues.endpoint
}

###########################################
# MLServices VSSOCCER
# module "mlservices_vssoccer" {
#   #source = "github.com/graymeta/terraform12-aws-platform//modules/mlservices/vssoccer?ref=master"
#   source = "../../../../terraform12-aws-platform/modules/mlservices/vssoccer"

#   instance_type                   = "m5.xlarge"
#   key_name                        = var.key_name
#   max_cluster_size                = 2
#   min_cluster_size                = 1
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


