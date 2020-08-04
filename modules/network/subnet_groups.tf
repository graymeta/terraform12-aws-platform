resource "aws_elasticache_subnet_group" "cache" {
  name       = "GrayMetaPlatform-${var.platform_instance_id}-cache"
  subnet_ids = [aws_subnet.services_1.id, aws_subnet.services_1.id]
}
