variable "custom_labels_bucket" {
  type = string
}

variable "cw_dest_bucket_arn" {
  type        = map(string)
  description = "The destination s3 bucket for export logs"

  default = {
    "ap-southeast-2" = "arn:aws:s3:::gm-terraform-export-ap-southeast-2"
    "eu-west-1"      = "arn:aws:s3:::gm-terraform-export-eu-west-1"
    "us-east-1"      = "arn:aws:s3:::gm-terraform-export-us-east-1"
    "us-east-2"      = "arn:aws:s3:::gm-terraform-export-us-east-2"
    "us-west-2"      = "arn:aws:s3:::gm-terraform-export-us-west-2"
  }
}

variable "file_api_bucket" {
  type = string
}

variable "notifications_from_addr" {
  type = string
}

variable "platform_instance_id" {
  type = string
}

variable "services_role_name" {
  type = string
}

variable "sns_harvest_complete_arn" {
  type = string
}

variable "sqs_activity_arn" {
  type = string
}

variable "sqs_index_arn" {
  type = string
}

variable "sqs_itemcleanup_arn" {
  type = string
}

variable "sqs_s3notifications_arn" {
  type = string
}

variable "sqs_stage01_arn" {
  type = string
}

variable "sqs_stage02_arn" {
  type = string
}

variable "sqs_stage03_arn" {
  type = string
}

variable "sqs_stage04_arn" {
  type = string
}

variable "sqs_stage05_arn" {
  type = string
}

variable "sqs_stage06_arn" {
  type = string
}

variable "sqs_stage07_arn" {
  type = string
}

variable "sqs_stage08_arn" {
  type = string
}

variable "sqs_stage09_arn" {
  type = string
}

variable "sqs_stage10_arn" {
  type = string
}

variable "sqs_walk_arn" {
  type = string
}

variable "temp_bucket" {
  type = string
}

variable "usage_bucket" {
  type = string
}
