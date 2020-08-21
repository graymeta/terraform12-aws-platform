data "aws_subnet" "subnet_mlservices_1" {
  id = var.mlservices_subnet_id_1
}

data "aws_subnet" "subnet_mlservices_2" {
  id = var.mlservices_subnet_id_2
}

resource "aws_lb" "ml_alb" {
  enable_deletion_protection = false
  internal                   = true
  load_balancer_type         = "application"
  name_prefix                = "ml-"
  security_groups            = [aws_security_group.ml_alb.id]
  subnets                    = [var.mlservices_subnet_id_1, var.mlservices_subnet_id_2]

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ML-ALB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

# Create the Loadbalancer listener and target group on the ML loadbalancer
resource "aws_lb_listener" "cluster" {
  load_balancer_arn = var.ml_loadbalancer_output["ml_alb_id"]
  port              = var.port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.cluster.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "cluster" {
  port     = var.port
  protocol = "HTTP"
  vpc_id   = var.ml_loadbalancer_output["vpc_id"]

  health_check {
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/healthz/"
    port                = var.port
    protocol            = "HTTP"
    timeout             = 20
    unhealthy_threshold = 2
  }

  tags = {
    Name               = "GrayMetaPlatform-${var.ml_loadbalancer_output["platform_instance_id"]}-ML${var.service_name}"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.ml_loadbalancer_output["platform_instance_id"]
  }
}

# Allow Services and ECS networks
resource "aws_security_group_rule" "allow_cluster" {
  description       = "allow-cluster-port"
  security_group_id = var.ml_loadbalancer_output["ml_alb_security_group_id"]
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = ["${var.services_ecs_cidrs}"]
}

