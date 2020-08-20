resource "aws_security_group" "proxy" {
  description = "Proxy nodes Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Proxy"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.proxy.id
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_22" {
  security_group_id = aws_security_group.proxy.id
  description       = "Allow tcp/22 ssh_cidr_blocks"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = split(",", var.ssh_cidr_blocks)
}

resource "aws_security_group_rule" "ingress_3128_services" {
  security_group_id        = aws_security_group.proxy.id
  description              = "Allow tcp/3128 Services"
  type                     = "ingress"
  from_port                = 3128
  to_port                  = 3128
  protocol                 = "tcp"
  source_security_group_id = var.services_nsg
}

resource "aws_security_group_rule" "ingress_3128_ecs" {
  security_group_id        = aws_security_group.proxy.id
  description              = "Allow tcp/3128 Ecs"
  type                     = "ingress"
  from_port                = 3128
  to_port                  = 3128
  protocol                 = "tcp"
  source_security_group_id = var.ecs_nsg
}

resource "aws_security_group_rule" "ingress_3128_mlservices" {
  security_group_id        = aws_security_group.proxy.id
  description              = "Allow tcp/3128 MLServices"
  type                     = "ingress"
  from_port                = 3128
  to_port                  = 3128
  protocol                 = "tcp"
  source_security_group_id = var.mlservices_nsg
}