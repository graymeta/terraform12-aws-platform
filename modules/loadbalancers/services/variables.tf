variable "platform_instance_id" { type = string }
variable "services_alb_nsg" { type = string }
variable "services_alb_internal" {
  type    = bool
  default = false
}
variable "ssl_certificate_arn" { type = string }
variable "subnets" { type = list(string) }
