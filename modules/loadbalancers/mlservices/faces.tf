resource "aws_lb_listener" "faces" {
  load_balancer_arn = aws_lb.mlservices_alb.arn
  port              = local.faces_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.faces.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "faces" {
  port     = local.faces_port
  protocol = "HTTP"
  vpc_id   = data.aws_subnet.subnet_1.vpc_id

  health_check {
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/healthz/"
    port                = local.faces_port
    protocol            = "HTTP"
    timeout             = 20
    unhealthy_threshold = 2
  }

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-MLfaces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

output "target_group_faces_arn" {
  value = aws_lb_target_group.faces.arn
}
