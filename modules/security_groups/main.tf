module "services_alb" {
  source = "./services_alb"

  ecs_nsg               = module.ecs.ecs_nsg
  platform_access_cidrs = var.platform_access_cidrs
  platform_instance_id  = var.platform_instance_id
  services_nsg          = module.services.services_nsg
  vpc_id                = var.vpc_id
}

module "services" {
  source = "./services"

  platform_instance_id = var.platform_instance_id
  services_alb_nsg     = module.services_alb.services_alb_nsg
  ssh_cidr_blocks      = var.ssh_cidr_blocks
  vpc_id               = var.vpc_id
}

module "elasticsearch" {
  source = "./elasticsearch"

  platform_instance_id = var.platform_instance_id
  services_nsg         = module.services.services_nsg
  vpc_id               = var.vpc_id
}

module "elasticache" {
  source = "./elasticache"

  platform_instance_id = var.platform_instance_id
  services_nsg         = module.services.services_nsg
  vpc_id               = var.vpc_id
}

module "rds" {
  source = "./rds"

  platform_instance_id = var.platform_instance_id
  services_nsg         = module.services.services_nsg
  vpc_id               = var.vpc_id
}

module "ecs" {
  source = "./ecs"

  platform_instance_id = var.platform_instance_id
  services_nsg         = module.services.services_nsg
  ssh_cidr_blocks      = var.ssh_cidr_blocks
  vpc_id               = var.vpc_id
}

module "mlservices" {
  source = "./mlservices"

  platform_instance_id   = var.platform_instance_id
  ecs_nsg                = module.ecs.ecs_nsg
  mlservices_subnet_id_1 = var.mlservices_subnet_id_1
  mlservices_subnet_id_2 = var.mlservices_subnet_id_2
  services_nsg           = module.services.services_nsg
  ssh_cidr_blocks        = var.ssh_cidr_blocks
  vpc_id                 = var.vpc_id
}

module "proxy" {
  source = "./proxy"

  platform_instance_id = var.platform_instance_id
  proxy_subnet_id_1    = var.proxy_subnet_id_1
  proxy_subnet_id_2    = var.proxy_subnet_id_2
  ecs_nsg              = module.ecs.ecs_nsg
  mlservices_nsg       = module.mlservices.mlservices_nsg
  services_nsg         = module.services.services_nsg
  ssh_cidr_blocks      = var.ssh_cidr_blocks
  vpc_id               = var.vpc_id
}
