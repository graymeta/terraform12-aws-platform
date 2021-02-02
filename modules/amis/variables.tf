variable "ecs_amis" {
  type        = map(string)
  description = "map of region to ami for ecs nodes"

  default = {
    "ap-southeast-2" = "ami-0ef1e3e13b73b2293"
    "eu-west-1"      = "ami-0b120bdb5925c3e65"
    "us-east-1"      = "ami-07de85a727f50bf9c"
    "us-east-2"      = "ami-0d8f4adb469d571f3"
    "us-west-2"      = "ami-0841b3b42d982478e"
  }
}

variable "mlservices_amis" {
  type        = map(string)
  description = "map of region to ami for mlservices nodes"

  default = {
    "ap-southeast-2" = "ami-01f28bb215cd2aac5"
    "eu-west-1"      = "ami-071ee3e74b827b725"
    "us-east-1"      = "ami-0e6085b261c1f6174"
    "us-east-2"      = "ami-08d69724549a46439"
    "us-west-2"      = "ami-06c8d7b3257fa2578"
  }
}

variable "proxy_amis" {
  type        = map(string)
  description = "map of region to ami for proxy nodes"

  default = {
    "ap-southeast-2" = "ami-0e34be4c00fc1af81"
    "eu-west-1"      = "ami-06de05e2cad8f075e"
    "us-east-1"      = "ami-07d63fc89a01a2ac1"
    "us-east-2"      = "ami-0f2db2417a84d60a3"
    "us-west-2"      = "ami-0c6208b19d06864fa"
  }
}

variable "services_amis" {
  type        = map(string)
  description = "map of region to ami for services nodes"

  default = {
    "ap-southeast-2" = "ami-0fac20dbe978b63e0"
    "eu-west-1"      = "ami-0d2f43a921842aecf"
    "us-east-1"      = "ami-0513e6d7055e5b527"
    "us-east-2"      = "ami-039b47c1c675581aa"
    "us-west-2"      = "ami-07c90f022ac778a77"
  }
}
