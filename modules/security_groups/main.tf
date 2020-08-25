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

module "rds_faces" {
  source = "./rds_faces"

  platform_instance_id = var.platform_instance_id
  mlservices_nsg       = module.mlservices.mlservices_nsg
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
  ecs_subnet_id_1        = var.ecs_subnet_id_1
  ecs_subnet_id_2        = var.ecs_subnet_id_2
  mlservices_subnet_id_1 = var.mlservices_subnet_id_1
  mlservices_subnet_id_2 = var.mlservices_subnet_id_2
  services_subnet_id_1   = var.services_subnet_id_1
  services_subnet_id_2   = var.services_subnet_id_2
  ssh_cidr_blocks        = var.ssh_cidr_blocks
  vpc_id                 = var.vpc_id
}

module "mlservices_alb" {
  source = "./mlservices_alb"

  ecs_nsg               = module.ecs.ecs_nsg
  platform_access_cidrs = var.platform_access_cidrs
  platform_instance_id  = var.platform_instance_id
  services_nsg          = module.services.services_nsg
  vpc_id                = var.vpc_id
}

module "proxy" {
  source = "./proxy"

  ecs_subnet_id_1        = var.ecs_subnet_id_1
  ecs_subnet_id_2        = var.ecs_subnet_id_2
  mlservices_subnet_id_1 = var.mlservices_subnet_id_1
  mlservices_subnet_id_2 = var.mlservices_subnet_id_2
  platform_instance_id   = var.platform_instance_id
  proxy_subnet_id_1      = var.proxy_subnet_id_1
  proxy_subnet_id_2      = var.proxy_subnet_id_2
  services_subnet_id_1   = var.services_subnet_id_1
  services_subnet_id_2   = var.services_subnet_id_2
  ssh_cidr_blocks        = var.ssh_cidr_blocks
  vpc_id                 = var.vpc_id
}
