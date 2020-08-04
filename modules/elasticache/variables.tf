
variable "elasticache_security_group" {
  type = string
}
variable "elasticache_subnet_group_name" {
  type = string
}
variable "instance_type_services" {}
variable "platform_instance_id" {}
variable "subnet_id_1" {}
variable "subnet_id_2" {}

data "aws_subnet" "subnet_1" {
  id = var.subnet_id_1
}

data "aws_subnet" "subnet_2" {
  id = var.subnet_id_2
}
