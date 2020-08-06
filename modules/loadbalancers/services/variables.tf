variable "services_alb_nsg" { type = string }
variable "subnets" { type = list(string) }
variable "platform_instance_id" { type = string }
variable "ssl_certificate_arn" { type = string }


data "aws_subnet" "subnet_1" {
  id = var.subnets[0]
}