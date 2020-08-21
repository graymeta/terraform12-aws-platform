resource "aws_security_group" "mlservices_alb" {
  description = "MLServices ALB Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-MLServicesALB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = "${var.platform_instance_id}"
  }
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.mlservices_alb.id
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_services_nsg" {
  security_group_id        = aws_security_group.mlservices_alb.id
  description              = "Allow tcp/10300-10310 services_nsg"
  type                     = "ingress"
  from_port                = 10300
  to_port                  = 10310
  protocol                 = "tcp"
  source_security_group_id = var.services_nsg
}

resource "aws_security_group_rule" "ingress_ecs_nsg" {
  security_group_id        = aws_security_group.mlservices_alb.id
  description              = "Allow tcp/10300-10310 ecs_nsg"
  type                     = "ingress"
  from_port                = 10300
  to_port                  = 10310
  protocol                 = "tcp"
  source_security_group_id = var.ecs_nsg
}
