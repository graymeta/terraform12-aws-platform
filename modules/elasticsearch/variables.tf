variable "dedicated_master_count" {
  type        = string
  description = "Number of dedicated master nodes in the cluster"
}
variable "dedicated_master_type" {
  type        = string
  description = "Instance type of the dedicated master nodes in the cluster."
}

variable "elasticsearch_security_group" {
  type = string
}

variable "instance_count" {
  type        = string
  description = "Number of instances in the cluster."
}

variable "instance_type" {
  type        = string
  description = "Instance type of data nodes in the cluster."
}

variable "platform_instance_id" {
  type        = string
  description = "A human-readable string for this instance of the GrayMeta Platform."
}

variable "region" {
  type        = string
  description = "The region to deploy in."
}

variable "subnet_id_1" {}

variable "subnet_id_2" {}

variable "volume_size" {
  type        = string
  description = "The size of EBS volumes attached to data nodes (in GB)."
}

data "aws_caller_identity" "current" {}

data "aws_subnet" "subnet_1" {
  id = var.subnet_id_1
}

data "aws_subnet" "subnet_2" {
  id = var.subnet_id_2
}
