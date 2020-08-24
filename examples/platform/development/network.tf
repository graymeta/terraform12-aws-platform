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
