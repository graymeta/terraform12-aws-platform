variable "ml_loadbalancer_output" {
  type = map(string)
}
variable "port" {}
variable "services_ecs_cidrs" {
  type = list(string)
}
variable "service_name" {}
