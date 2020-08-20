resource "aws_elasticache_cluster" "services" {
  cluster_id           = "gm-${var.platform_instance_id}"
  engine               = "redis"
  engine_version       = "3.2.10"
  node_type            = var.instance_type
  port                 = 6379
  num_cache_nodes      = 1
  security_group_ids   = [var.elasticache_security_group]
  subnet_group_name    = var.elasticache_subnet_group_name
  parameter_group_name = "default.redis3.2"
}
