variable "platform_instance_id" {
  type        = string
  description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "subnet_id_1" {}
variable "subnet_id_2" {}

data "aws_subnet" "subnet_1" {
  id = "${var.subnet_id_1}"
}

data "aws_subnet" "subnet_2" {
  id = "${var.subnet_id_2}"
}
