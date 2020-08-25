output "default_route_table_id" {
  value = aws_vpc.main.default_route_table_id
}

output "ecs_cidrs" {
  value = [
    "${aws_subnet.ecs.cidr_block}",
    "${aws_subnet.ecs_2.cidr_block}",
  ]
}

output "ecs_subnet_id_1" {
  value = aws_subnet.ecs.id
}

output "ecs_subnet_id_2" {
  value = aws_subnet.ecs_2.id
}

output "elasticache_subnet_group_name" {
  value = aws_elasticache_subnet_group.cache.name
}

output "elasticsearch_subnet_id_1" {
  value = aws_subnet.elasticsearch_1.id
}

output "elasticsearch_subnet_id_2" {
  value = aws_subnet.elasticsearch_2.id
}

output "mlservices_cidrs" {
  value = [
    "${aws_subnet.mlservices_1.cidr_block}",
    "${aws_subnet.mlservices_2.cidr_block}",
  ]
}

output "mlservices_subnet_id_1" {
  value = aws_subnet.mlservices_1.id
}

output "mlservices_subnet_id_2" {
  value = aws_subnet.mlservices_2.id
}

output "proxy_subnet_id_1" {
  value = aws_subnet.proxy_1.id
}

output "proxy_subnet_id_2" {
  value = aws_subnet.proxy_2.id
}

output "public_subnet_id_1" {
  value = aws_subnet.public_1.id
}

output "public_subnet_id_2" {
  value = aws_subnet.public_2.id
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds.name
}

output "rds_faces_subnet_group_name" {
  value = aws_db_subnet_group.rds-faces.name
}

output "rds_subnet_id_1" {
  value = aws_subnet.rds_1.id
}

output "rds_subnet_id_2" {
  value = aws_subnet.rds_2.id
}

output "services_cidrs" {
  value = [
    "${aws_subnet.services_1.cidr_block}",
    "${aws_subnet.services_2.cidr_block}",
  ]
}

output "services_subnet_id_1" {
  value = aws_subnet.services_1.id
}

output "services_subnet_id_2" {
  value = aws_subnet.services_2.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
