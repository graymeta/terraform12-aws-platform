resource "aws_default_route_table" "main" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-Main"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_route_table" "az1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.az1.id
  }

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-az1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_route_table" "az2" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.az2.id
  }

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-az2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = var.public_subnet_id_1
  route_table_id = aws_default_route_table.main.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = var.public_subnet_id_2
  route_table_id = aws_default_route_table.main.id
}

resource "aws_route_table_association" "ecs_1" {
  subnet_id      = var.ecs_subnet_id_1
  route_table_id = aws_route_table.az1.id
}

resource "aws_route_table_association" "ecs_2" {
  subnet_id      = var.ecs_subnet_id_2
  route_table_id = aws_route_table.az2.id
}

resource "aws_route_table_association" "mlservices_1" {
  subnet_id      = var.mlservices_subnet_id_1
  route_table_id = aws_route_table.az1.id
}

resource "aws_route_table_association" "mlservices_2" {
  subnet_id      = var.mlservices_subnet_id_2
  route_table_id = aws_route_table.az2.id
}

resource "aws_route_table_association" "services_1" {
  subnet_id      = var.services_subnet_id_1
  route_table_id = aws_route_table.az1.id
}

resource "aws_route_table_association" "services_2" {
  subnet_id      = var.services_subnet_id_2
  route_table_id = aws_route_table.az2.id
}
