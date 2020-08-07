resource "aws_autoscaling_group" "ecs" {
  name_prefix          = "GrayMetaPlatform-${var.platform_instance_id}-ECS-"
  max_size             = var.ecs_max_cluster_size
  min_size             = var.ecs_min_cluster_size
  force_delete         = true
  launch_configuration = aws_launch_configuration.ecs.name
  vpc_zone_identifier  = [var.ecs_subnet_id_1, var.ecs_subnet_id_2]

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = "15m"
  }

  tags = [
    {
      key                 = "Name"
      value               = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
      propagate_at_launch = true
    },
    {
      key                 = "ApplicationName"
      value               = "GrayMetaPlatform"
      propagate_at_launch = true
    },
    {
      key                 = "PlatformInstanceID"
      value               = var.platform_instance_id
      propagate_at_launch = true
    },
  ]
}

resource "aws_launch_configuration" "ecs" {
  name_prefix          = "GrayMetaPlatform-${var.platform_instance_id}-ECS-"
  image_id             = var.ecs_ami_id
  instance_type        = var.ecs_instance_type
  iam_instance_profile = var.ecs_iam_instance_profile
  key_name             = var.key_name
  security_groups      = [var.ecs_nsg]
  user_data_base64     = data.template_cloudinit_config.config.rendered

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.ecs_volume_size
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-ECS-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ecs.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-ECS-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 180
  autoscaling_group_name = aws_autoscaling_group.ecs.name
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-ECS-scale-up-mem"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "65"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.ecs_cluster.name
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-ECS-scale-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "20"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.ecs_cluster.name
  }
}
