resource "aws_security_group" "elasticache" {
  description = "Access to Elasticache clusters"
  vpc_id      = data.aws_subnet.subnet_1.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Elasticache"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = aws_security_group.elasticache.id
  description       = "Elasticache ingress security group rule."
  type              = "ingress"
  from_port         = 6739
  to_port           = 6739
  protocol          = "tcp"
  cidr_blocks       = ["${data.aws_subnet.subnet_1.cidr_block}", "${data.aws_subnet.subnet_2.cidr_block}"]
}
