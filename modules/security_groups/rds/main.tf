resource "aws_security_group" "rds" {
  description = "Access to RDS"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_security_group_rule" "ingress" {
  security_group_id        = aws_security_group.rds.id
  description              = "RDS ingress security group rule."
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.services_nsg
}
