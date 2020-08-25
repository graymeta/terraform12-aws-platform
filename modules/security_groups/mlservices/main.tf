resource "aws_security_group" "mlservices" {
  description = "MLServices nodes Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-MLServices"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.mlservices.id
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_22" {
  security_group_id = aws_security_group.mlservices.id
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

resource "aws_security_group_rule" "ingress_services" {
  security_group_id = aws_security_group.mlservices.id
  description       = "Allow tcp/10300-10310 services subnets"
  type              = "ingress"
  from_port         = 10300
  to_port           = 10310
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

resource "aws_security_group_rule" "ingress_ecs" {
  security_group_id = aws_security_group.mlservices.id
  description       = "Allow tcp/10300-10310 ecs subnets"
  type              = "ingress"
  from_port         = 10300
  to_port           = 10310
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

resource "aws_security_group_rule" "ingress_3128_proxy" {
  security_group_id = aws_security_group.mlservices.id
  description       = "Allow tcp/10300-10310 mlservices subnets"
  type              = "ingress"
  from_port         = 10300
  to_port           = 10310
  protocol          = "tcp"
  cidr_blocks = [
    data.aws_subnet.mlservices_subnet_id_1.cidr_block,
    data.aws_subnet.mlservices_subnet_id_2.cidr_block,
  ]
}

# Faces 
resource "aws_security_group" "rds" {
  name_prefix = "${var.platform_instance_id}-faces"
  description = "Access to faces RDS Service"
  vpc_id      = data.aws_subnet.rds.vpc_id

  tags {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-faces"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_security_group_rule" "rds_allow_servers" {
  security_group_id = aws_security_group.rds.id
  description       = "Allow Faces Nodes"
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"

  cidr_blocks = [
    "${data.aws_subnet.subnet_faces_1.cidr_block}",
    "${data.aws_subnet.subnet_faces_2.cidr_block}",
  ]
}

data "aws_subnet" "rds" {
  id = var.rds_subnet_id_1
}

data "aws_subnet" "subnet_faces_1" {
  id = var.ml_loadbalancer_output["faces_subnet_id_1"]
}

data "aws_subnet" "subnet_faces_2" {
  id = var.ml_loadbalancer_output["faces_subnet_id_2"]
}
