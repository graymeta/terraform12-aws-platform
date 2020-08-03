resource "aws_security_group" "elasticsearch" {
  description = "Access to elasticsearch"
  vpc_id      = data.aws_subnet.subnet_1.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Elasticsearch"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

# resource "aws_security_group_rule" "ingress" {
#   security_group_id = aws_security_group.elasticsearch.id
#   description       = "Elasticsearch ingres security group rule."
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   security_groups   = [split(",", var.security_group_ids)]
# }

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.elasticsearch.id
  description       = "Elasticsearch egress security group rule."
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
