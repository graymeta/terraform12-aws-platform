variable "cloud_init" {}
variable "instance_type" {}
variable "max_cluster_size" {}
variable "min_cluster_size" {}
variable "ml_loadbalancer_output" {
  type = map(string)
}
variable "port" {}
variable "service_name" {}
variable "services_ecs_cidrs" {
  type = list(string)
}
variable "user_init" {}
variable "volume_size" {}
data "aws_region" "current" {}
