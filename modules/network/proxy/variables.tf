variable "default_route_table_id" {
  type        = string
  description = "the default route table id for vpc"
}

variable "platform_instance_id" {
  type = string
}

variable "public_subnet_id_1" {
  type        = string
  description = "subnet id for az1 to put NAT gateways in"
}

variable "public_subnet_id_2" {
  type        = string
  description = "subnet id for az2 to put NAT gateways in"
}

variable "proxy_subnet_id_1" {
  type        = string
  description = "the proxy_subnet_id for az1"
}

variable "proxy_subnet_id_2" {
  type        = string
  description = "the proxy_subnet_id for az2"
}

variable "region" {
  type        = string
  description = "region for s3 aws_vpc_endpoint"
}

variable "vpc_id" {
  type        = string
  description = "The vpc_id to apply gateways and routes too"
}
