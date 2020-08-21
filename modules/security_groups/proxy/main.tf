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

data "aws_subnet" "services_subnet_id_1" {
  id = var.services_subnet_id_1
}

data "aws_subnet" "services_subnet_id_2" {
  id = var.services_subnet_id_2
}

resource "aws_security_group_rule" "ingress_3128_services" {
  security_group_id = aws_security_group.proxy.id
  description       = "Allow tcp/3128 services_nsg"
  type              = "ingress"
  from_port         = 3128
  to_port           = 3128
  protocol          = "tcp"
  cidr_blocks = [
    data.aws_subnet.services_subnet_id_1.cidr_block,
    data.aws_subnet.services_subnet_id_2.cidr_block,
  ]
}

data "aws_subnet" "ecs_subnet_id_1" {
  id = var.ecs_subnet_id_1
}

data "aws_subnet" "ecs_subnet_id_2" {
  id = var.ecs_subnet_id_2
}

resource "aws_security_group_rule" "ingress_3128_ecs" {
  security_group_id = aws_security_group.proxy.id
  description       = "Allow tcp/3128 ecs_nsg"
  type              = "ingress"
  from_port         = 3128
  to_port           = 3128
  protocol          = "tcp"
  cidr_blocks = [
    data.aws_subnet.ecs_subnet_id_1.cidr_block,
    data.aws_subnet.ecs_subnet_id_2.cidr_block,
  ]
}

data "aws_subnet" "mlservices_subnet_id_1" {
  id = var.mlservices_subnet_id_1
}

data "aws_subnet" "mlservices_subnet_id_2" {
  id = var.mlservices_subnet_id_2
}

resource "aws_security_group_rule" "ingress_3128_mlservices" {
  security_group_id = aws_security_group.proxy.id
  description       = "Allow tcp/3128 mlservices_nsg"
  type              = "ingress"
  from_port         = 3128
  to_port           = 3128
  protocol          = "tcp"
  cidr_blocks = [
    data.aws_subnet.mlservices_subnet_id_1.cidr_block,
    data.aws_subnet.mlservices_subnet_id_2.cidr_block,
  ]
}

data "aws_subnet" "proxy_subnet_id_1" {
  id = var.proxy_subnet_id_1
}

data "aws_subnet" "proxy_subnet_id_2" {
  id = var.proxy_subnet_id_2
}

resource "aws_security_group_rule" "ingress_3128_proxy" {
  security_group_id = aws_security_group.proxy.id
  description       = "Allow tcp/3128 proxy subnets"
  type              = "ingress"
  from_port         = 3128
  to_port           = 3128
  protocol          = "tcp"
  cidr_blocks = [
    data.aws_subnet.proxy_subnet_id_1.cidr_block,
    data.aws_subnet.proxy_subnet_id_2.cidr_block,
  ]
}




