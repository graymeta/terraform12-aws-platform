resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_eip" "nat_gateway_az1" {
  vpc = true
}

resource "aws_eip" "nat_gateway_az2" {
  vpc = true
}

resource "aws_nat_gateway" "az1" {
  allocation_id = aws_eip.nat_gateway_az1.id
  subnet_id     = var.public_subnet_id_1
  depends_on    = [aws_internet_gateway.main]

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-az1"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

resource "aws_nat_gateway" "az2" {
  allocation_id = aws_eip.nat_gateway_az2.id
  subnet_id     = var.public_subnet_id_2
  depends_on    = [aws_internet_gateway.main]

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-az2"
    Application        = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}
