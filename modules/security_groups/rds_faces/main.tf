resource "aws_security_group" "rds" {
  description = "Access to RDS"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-RDS-Faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_security_group_rule" "ingress" {
  security_group_id        = aws_security_group.rds.id
  description              = "Allow tcp/5432 mlservices_nsg"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.mlservices_nsg
}
