resource "aws_security_group" "ecs" {
  description = "Access to ECS"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.ecs.id
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress" {
  security_group_id        = aws_security_group.ecs.id
  description              = "Allow tcp/8125 services_nsg"
  type                     = "ingress"
  from_port                = 8125
  to_port                  = 8125
  protocol                 = "tcp"
  source_security_group_id = var.services_nsg
}

resource "aws_security_group_rule" "ingress_22" {
  security_group_id = aws_security_group.ecs.id
  description       = "Allow tcp/22 ssh_cidr_blocks"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = split(",", var.ssh_cidr_blocks)
}
