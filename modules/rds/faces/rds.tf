resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = var.instance_count
  identifier         = "gm-${var.platform_instance_id}-faces-${count.index}"
  cluster_identifier = aws_rds_cluster.postgresql.id
  engine             = "aurora-postgresql"
  engine_version     = var.rds_version
  instance_class     = var.rds_db_instance_size

  copy_tags_to_snapshot = true

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_rds_cluster" "postgresql" {
  apply_immediately         = true
  backup_retention_period   = var.rds_backup_retention
  cluster_identifier        = "gm-${var.platform_instance_id}-faces"
  database_name             = "faces"
  db_subnet_group_name      = var.rds_subnet_group_name
  engine                    = "aurora-postgresql"
  engine_version            = var.rds_version
  final_snapshot_identifier = "GrayMetaPlatform-${var.platform_instance_id}-faces-aurora-final"
  master_password           = var.rds_db_password
  master_username           = var.rds_db_username
  port                      = "5432"
  preferred_backup_window   = var.rds_backup_window
  storage_encrypted         = true
  vpc_security_group_ids    = [var.rds_nsg]

  snapshot_identifier = var.rds_snapshot == "final" ? format("GrayMetaPlatform-${var.platform_instance_id}-faces-aurora-final") : var.rds_snapshot

  lifecycle = {
    ignore_changes = [
      storage_encrypted
      kms_key_id
      snapshot_identifier
    ]
  }

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_appautoscaling_target" "replicas" {
  service_namespace  = "rds"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  resource_id        = "cluster:${aws_rds_cluster.postgresql.id}"
  min_capacity       = 1
  max_capacity       = var.rds_asg_max_capacity
}

resource "aws_appautoscaling_policy" "replicas" {
  name               = "cpu-auto-scaling"
  service_namespace  = aws_appautoscaling_target.replicas.service_namespace
  scalable_dimension = aws_appautoscaling_target.replicas.scalable_dimension
  resource_id        = aws_appautoscaling_target.replicas.resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }

    target_value       = var.rds_asg_target_cpu
    scale_in_cooldown  = var.rds_asg_scalein_cooldown
    scale_out_cooldown = var.rds_asg_scaleout_cooldown
  }
}
