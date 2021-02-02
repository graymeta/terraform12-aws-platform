resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = var.instance_count
  identifier         = "gm-${var.platform_instance_id}-platform-${count.index}"
  cluster_identifier = aws_rds_cluster.postgresql.id
  engine             = "aurora-postgresql"
  engine_version     = var.rds_version
  instance_class     = var.rds_instance_size

  copy_tags_to_snapshot = true

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_rds_cluster" "postgresql" {
  apply_immediately         = var.apply_immediately
  backup_retention_period   = var.rds_backup_retention
  cluster_identifier        = "gm-${var.platform_instance_id}"
  database_name             = var.rds_database_name
  db_subnet_group_name      = var.rds_subnet_group_name
  engine                    = "aurora-postgresql"
  engine_version            = var.rds_version
  final_snapshot_identifier = "GrayMetaPlatform-${var.platform_instance_id}-final"
  master_password           = var.rds_password
  master_username           = var.rds_username
  port                      = "5432"
  preferred_backup_window   = var.rds_backup_window
  storage_encrypted         = var.rds_storage_encrypted
  vpc_security_group_ids    = [var.rds_nsg]

  snapshot_identifier = var.rds_snapshot == "final" ? format("GrayMetaPlatform-${var.platform_instance_id}-services-final") : var.rds_snapshot

  lifecycle {
    ignore_changes = [
      storage_encrypted,
      kms_key_id,
      snapshot_identifier,
      master_password
    ]
  }

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}
