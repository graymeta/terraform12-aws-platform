resource "aws_vpc_endpoint" "vpc_endpoint_s3" {
  vpc_id            = var.vpc_id
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${var.region}.s3"

  route_table_ids = [
    aws_route_table.az1.id,
    aws_route_table.az2.id,
    aws_default_route_table.main.id,
  ]
}
