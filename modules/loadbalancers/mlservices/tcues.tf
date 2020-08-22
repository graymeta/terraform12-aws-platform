resource "aws_lb_listener" "tcues" {
  load_balancer_arn = aws_lb.mlservices_alb.arn
  port              = local.tcues_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tcues.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "tcues" {
  port     = local.tcues_port
  protocol = "HTTP"
  vpc_id   = data.aws_subnet.subnet_1.vpc_id

  health_check {
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/healthz/"
    port                = local.tcues_port
    protocol            = "HTTP"
    timeout             = 20
    unhealthy_threshold = 2
  }

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-MLtcues"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

output "target_group_tcues_arn" {
  value = aws_lb_target_group.tcues.arn
}
