output "ecs_nsg" {
  value = module.ecs.ecs_nsg
}

output "elasticache_nsg" {
  value = module.elasticache.elasticache_nsg
}

output "elasticsearch_nsg" {
  value = module.elasticsearch.elasticsearch_nsg
}

output "mlservices_alb_nsg" {
  value = module.mlservices_alb.mlservices_alb_nsg
}

output "mlservices_nsg" {
  value = module.mlservices.mlservices_nsg
}

output "proxy_nsg" {
  value = module.proxy.proxy_nsg
}

output "rds_nsg" {
  value = module.rds.rds_nsg
}

output "rds_faces_nsg" {
  value = module.rds_faces.rds_faces_nsg
}

output "services_alb_nsg" {
  value = module.services_alb.services_alb_nsg
}

output "services_nsg" {
  value = module.services.services_nsg
}
