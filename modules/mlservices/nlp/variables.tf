variable "instance_type" {
  type        = string
  description = "ec2 instance type"
}

variable "key_name" { type = string }

variable "max_cluster_size" {
  type        = string
  description = "The max number of ec2 instances to spin up"
}

variable "min_cluster_size" {
  type        = string
  description = "The min number of ec2 instances to spin up"
}

variable "mlservices_alb_dns" { type = string }
variable "mlservices_ami_id" { type = string }
variable "mlservices_iam_instance_profile" { type = string }
variable "mlservices_nsg" { type = string }
variable "mlservices_subnet_id_1" { type = string }
variable "mlservices_subnet_id_2" { type = string }
variable "platform_instance_id" { type = string }
variable "target_group_mlservices_arn" { type = string }

variable "user_init" {
  type        = string
  description = "Custom cloud-init that is rendered to be used on cluster instances. (Not Recommened)"
  default     = ""
}

variable "volume_size" {
  type        = string
  description = "The OS disk size for credits Server"
  default     = "50"
}
