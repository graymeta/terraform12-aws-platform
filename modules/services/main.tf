locals {
  cfn_stack_name = "GrayMetaPlatform-${var.platform_instance_id}-Services-ASG"
}

resource "aws_launch_configuration" "launch_config_services" {
  name_prefix          = "GrayMetaPlatform-${var.platform_instance_id}-Services-"
  image_id             = var.services_ami_id
  instance_type        = var.services_instance_type
  iam_instance_profile = var.services_iam_instance_profile
  key_name             = var.key_name
  security_groups      = [var.services_nsg]
  user_data_base64     = data.template_cloudinit_config.config.rendered

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 50
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Loading the template_body from a template file decouples the dependency between the LC and ASG and breaks the update, so use a HEREDOC instead :(
# See https://github.com/hashicorp/terraform/issues/1552 for more info
resource "aws_cloudformation_stack" "services_asg" {
  name               = local.cfn_stack_name
  timeout_in_minutes = "90"

  timeouts {
    create = "90m"
    update = "90m"
  }

  template_body = <<EOF
{
  "Resources": {
    "AutoScalingGroup": {
      "Type": "AWS::AutoScaling::AutoScalingGroup",
      "Properties": {
        "LaunchConfigurationName": "${aws_launch_configuration.launch_config_services.name}",
        "MaxSize": "${var.services_max_cluster_size}",
        "MinSize": "${var.services_min_cluster_size}",
        "Tags": [
          {
            "Key": "Name",
            "Value": "GrayMetaPlatform-${var.platform_instance_id}-Services",
            "PropagateAtLaunch": true
          },
          {
            "Key": "ApplicationName",
            "Value": "GrayMetaPlatform",
            "PropagateAtLaunch": true
          },
          {
            "Key": "PlatformInstanceID",
            "Value": "${var.platform_instance_id}",
            "PropagateAtLaunch": true
          }
        ],
        "TargetGroupARNs": [
            "${var.target_group_7000_arn}",
            "${var.target_group_7009_arn}"
        ],
        "TerminationPolicies": [
          "OldestLaunchConfiguration",
          "OldestInstance",
          "Default"
        ],
        "VPCZoneIdentifier": [
            "${var.services_subnet_id_1}",
            "${var.services_subnet_id_2}"
        ]
      },
      "UpdatePolicy": {
        "AutoScalingRollingUpdate": {
          "MinInstancesInService": "${var.services_min_cluster_size}",
          "MaxBatchSize": "2",
          "PauseTime": "PT0S"
        }
      }
    }
  },
  "Outputs": {
    "AsgName": {
      "Description": "The name of the auto scaling group",
      "Value": {
        "Ref": "AutoScalingGroup"
      }
    }
  }
}
EOF
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Services-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_cloudformation_stack.services_asg.outputs["AsgName"]
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "GrayMetaPlatform-${var.platform_instance_id}-Services-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_cloudformation_stack.services_asg.outputs["AsgName"]
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Services-scale-up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = var.services_scale_up_threshold_cpu
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_cloudformation_stack.services_asg.outputs["AsgName"]
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "GrayMetaPlatform-${var.platform_instance_id}-Services-scale-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.services_scale_down_threshold_cpu
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_cloudformation_stack.services_asg.outputs["AsgName"]
  }
}
