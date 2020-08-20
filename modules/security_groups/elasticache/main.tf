resource "aws_security_group" "elasticache" {
  description = "Access to Elasticache clusters"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Elasticache"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_security_group_rule" "ingress" {
  security_group_id        = aws_security_group.elasticache.id
  description              = "Allow tcp/6739 services_nsg"
  type                     = "ingress"
  from_port                = 6739
  to_port                  = 6739
  protocol                 = "tcp"
  source_security_group_id = var.services_nsg
}
