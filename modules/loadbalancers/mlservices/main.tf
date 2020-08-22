data "aws_subnet" "subnet_1" {
  id = var.subnets[0]
}

resource "aws_lb" "mlservices_alb" {
  name_prefix                = "ml-"
  internal                   = true
  security_groups            = [var.mlservices_alb_nsg]
  subnets                    = var.subnets
  enable_deletion_protection = false

  tags = {
    Name               = "GrayMetaPlatform-${var.platform_instance_id}-MLServicesALB"
    ApplicationName    = "GrayMetaPlatform"
    PlatformInstanceID = var.platform_instance_id
  }
}

output "mlservices_endpoint" {
  value = aws_lb.mlservices_alb.dns_name
}
