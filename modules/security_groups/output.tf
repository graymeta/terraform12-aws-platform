output "services_alb_nsg" {
  value = module.services_alb.nsg_id
}

output "services_nsg" {
  value = module.services.nsg_id
}

output "elasticsearch_nsg" {
  value = module.elasticsearch.nsg_id
}

output "elasticache_nsg" {
  value = module.elasticache.nsg_id
}

output "rds_nsg" {
  value = module.rds.nsg_id
}

output "ecs_nsg" {
  value = module.ecs.nsg_id
}
