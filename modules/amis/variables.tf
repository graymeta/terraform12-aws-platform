variable "ecs_amis" {
  type        = map(string)
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0c6be23f15f46d023"
    "eu-west-1"      = "ami-0dd15014cda81f372"
    "us-east-1"      = "ami-0a952c5d151e168b6"
    "us-east-2"      = "ami-0eb759b307672c622"
    "us-west-2"      = "ami-03faef593ca02f0eb"
  }
}

variable "mlservices_amis" {
  type        = map(string)
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-06dbfded852fdaefc"
    "eu-west-1"      = "ami-00db872b50379627f"
    "us-east-1"      = "ami-05bd7532c368a1ea3"
    "us-east-2"      = "ami-0443c093e4a9b4de5"
    "us-west-2"      = "ami-002f2df9a99a3ca57"
  }
}

variable "proxy_amis" {
  type        = map(string)
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-063df55c033ef83ee"
    "eu-west-1"      = "ami-044078feca893e7a2"
    "us-east-1"      = "ami-0192e29c1dc6bda61"
    "us-east-2"      = "ami-0b64211ae1a95e6cb"
    "us-west-2"      = "ami-09912216de0e1d633"
  }
}

variable "services_amis" {
  type        = map(string)
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0ae2ca2d7b9155d73"
    "eu-west-1"      = "ami-011d270027ca44470"
    "us-east-1"      = "ami-0580fa5c7653c7850"
    "us-east-2"      = "ami-01cee47cdf44b94c7"
    "us-west-2"      = "ami-09f930d3f6a35d320"
  }
}
