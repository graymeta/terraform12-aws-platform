variable "custom_labels_bucket" {
  type        = string
  description = "The custom_labels bucket name"
}

variable "file_api_bucket" {
  type        = string
  description = "The file_api bucket name"
}

# variable "platform_instance_id" {
#   type = string
#   description = "instance id of platform"
# }

variable "region" {
  type        = string
  description = "The region to deploy buckets"
}

variable "temp_bucket" {
  type        = string
  description = "The temp bucket name"
}

variable "usage_bucket" {
  type        = string
  description = "The usage bucket name"
}