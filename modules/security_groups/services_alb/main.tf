resource "aws_security_group" "services_alb" {
  description = "Services ALB Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ServicesALB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.services_alb.id
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_80" {
  security_group_id = aws_security_group.services_alb.id
  description       = "Allow tcp/80 platform_access_cidrs"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = split(",", var.platform_access_cidrs)
}

resource "aws_security_group_rule" "ingress_443" {
  security_group_id = aws_security_group.services_alb.id
  description       = "Allow tcp/443 platform_access_cidrs"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = split(",", var.platform_access_cidrs)
}

resource "aws_security_group_rule" "ingress_443_services" {
  security_group_id        = aws_security_group.services_alb.id
  description              = "Allow tcp/443 services_nsg"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = var.services_nsg
}

resource "aws_security_group_rule" "ingress_443_ecs" {
  security_group_id        = aws_security_group.services_alb.id
  description              = "Allow tcp/443 ecs_nsg"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = var.ecs_nsg
}

resource "aws_security_group_rule" "ingress_8443" {
  security_group_id = aws_security_group.services_alb.id
  description       = "Allow tcp/8443 platform_access_cidrs"
  type              = "ingress"
  from_port         = 8443
  to_port           = 8443
  protocol          = "tcp"
  cidr_blocks       = split(",", var.platform_access_cidrs)
}
