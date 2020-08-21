resource "aws_db_subnet_group" "rds" {
  subnet_ids = [aws_subnet.rds_1.id, aws_subnet.rds_2.id]

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_elasticache_subnet_group" "cache" {
  name       = "GrayMetaPlatform-${var.platform_instance_id}-cache"
  subnet_ids = [aws_subnet.services_1.id, aws_subnet.services_1.id]
}
