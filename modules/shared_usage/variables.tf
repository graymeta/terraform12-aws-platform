variable "graymeta_account" {
  type        = "string"
  description = "The GrayMeta account number that will have permission to read the Usage bucket"
  default     = "913397769129"
}

variable "usage_bucket" {
  type        = "string"
  description = "The usage bucket name"
}
