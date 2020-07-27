variable "bucket_name" {
  type        = string
  description = "The custom_labels bucket name"
}

# variable "platform_instance_id" {
#   type = string
#   // TODO
#   // This description sucks.
#   description = "instance id of platform"
# }

variable "region" {
  type        = string
  description = "The region to deploy"
}