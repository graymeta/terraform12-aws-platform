resource "aws_security_group" "services" {
  description = "Services nodes Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Services"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.services.id
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_22" {
  security_group_id = aws_security_group.services.id
  description       = "Allow tcp/22 ssh_cidr_blocks"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = split(",", var.ssh_cidr_blocks)
}

resource "aws_security_group_rule" "ingress_80" {
  security_group_id        = aws_security_group.services.id
  description              = "Allow tcp/80 services"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = var.services_alb_nsg
}

resource "aws_security_group_rule" "ingress_7000" {
  security_group_id        = aws_security_group.services.id
  description              = "Allow tcp/7000 services"
  type                     = "ingress"
  from_port                = 7000
  to_port                  = 7000
  protocol                 = "tcp"
  source_security_group_id = var.services_alb_nsg
}

resource "aws_security_group_rule" "ingress_7009" {
  security_group_id        = aws_security_group.services.id
  description              = "Allow tcp/7009 services"
  type                     = "ingress"
  from_port                = 7009
  to_port                  = 7009
  protocol                 = "tcp"
  source_security_group_id = var.services_alb_nsg
}

resource "aws_security_group_rule" "ingress_9090" {
  security_group_id        = aws_security_group.services.id
  description              = "Allow tcp/9090 services"
  type                     = "ingress"
  from_port                = 9090
  to_port                  = 9090
  protocol                 = "tcp"
  source_security_group_id = var.services_alb_nsg
}
