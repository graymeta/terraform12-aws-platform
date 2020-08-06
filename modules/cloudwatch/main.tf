resource "aws_cloudwatch_log_group" "services" {
  name              = "GrayMetaPlatform-${var.platform_instance_id}-Services"
  retention_in_days = var.log_retention

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Services"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
  retention_in_days = var.log_retention

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}