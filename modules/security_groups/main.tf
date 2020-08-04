module "services_alb" {
  source = "./services_alb"

  az1_nat_ip            = "10.240.0.11/32"
  az2_nat_ip            = "10.240.0.10/32"
  platform_access_cidrs = var.platform_access_cidrs
  platform_instance_id  = var.platform_instance_id
  vpc_id                = var.vpc_id
}

module "services" {
  source = "./services"

  platform_instance_id = var.platform_instance_id
  services_alb_nsg     = module.services_alb.nsg_id
  ssh_cidr_blocks      = var.ssh_cidr_blocks
  vpc_id               = var.vpc_id
}

module "elasticsearch" {
  source = "./elasticsearch"

  platform_instance_id = var.platform_instance_id
  services_nsg         = module.services.nsg_id
  vpc_id               = var.vpc_id
}

module "elasticache" {
  source = "./elasticache"

  platform_instance_id = var.platform_instance_id
  services_nsg         = module.services.nsg_id
  vpc_id               = var.vpc_id
}

module "rds" {
  source = "./rds"

  platform_instance_id = var.platform_instance_id
  services_nsg         = module.services.nsg_id
  vpc_id               = var.vpc_id
}

module "ecs" {
  source = "./ecs"

  platform_instance_id = var.platform_instance_id
  services_nsg         = module.services.nsg_id
  ssh_cidr_blocks      = var.ssh_cidr_blocks
  vpc_id               = var.vpc_id
}
