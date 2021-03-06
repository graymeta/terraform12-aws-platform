variable "az1" {
  type        = string
  description = "Availability zone 1"
}

variable "az2" {
  type        = string
  description = "Availability zone 2"
}

variable "cidr_subnet_ecs_1" {
  type        = string
  description = "The CIDR block to use for the ecs subnet"
  default     = "10.0.8.0/21"
}

variable "cidr_subnet_ecs_2" {
  type        = string
  description = "The CIDR block to use for the ecs subnet"
  default     = "10.0.24.0/21"
}

variable "cidr_subnet_elasticsearch_1" {
  type        = string
  description = "The CIDR block to use for the elasticsearch 1 subnet"
  default     = "10.0.16.0/24"
}

variable "cidr_subnet_elasticsearch_2" {
  type        = string
  description = "The CIDR block to use for the elasticsearch 2 subnet"
  default     = "10.0.17.0/24"
}

variable "cidr_subnet_mlservices_1" {
  type        = string
  description = "The CIDR block to use for the mlservices 1 subnet"
  default     = "10.0.18.0/24"
}

variable "cidr_subnet_mlservices_2" {
  type        = string
  description = "The CIDR block to use for the mlservices 2 subnet"
  default     = "10.0.19.0/24"
}

variable "cidr_subnet_proxy_1" {
  type        = string
  description = "The CIDR block to use for the proxy 1 subnet"
  default     = "10.0.20.0/24"
}

variable "cidr_subnet_proxy_2" {
  type        = string
  description = "The CIDR block to use for the proxy 2 subnet"
  default     = "10.0.21.0/24"
}

variable "cidr_subnet_public_1" {
  type        = string
  description = "The CIDR block to use for the public 1 subnet"
  default     = "10.0.0.0/24"
}

variable "cidr_subnet_public_2" {
  type        = string
  description = "The CIDR block to use for the public 2 subnet"
  default     = "10.0.1.0/24"
}

variable "cidr_subnet_rds_1" {
  type        = string
  description = "The CIDR block to use for the rds 1 subnet"
  default     = "10.0.2.0/24"
}

variable "cidr_subnet_rds_2" {
  type        = string
  description = "The CIDR block to use for the rds 2 subnet"
  default     = "10.0.3.0/24"
}

variable "cidr_subnet_services_1" {
  type        = string
  description = "The CIDR block to use for the services 1 subnet"
  default     = "10.0.4.0/24"
}

variable "cidr_subnet_services_2" {
  type        = string
  description = "The CIDR block to use for the services 2 subnet"
  default     = "10.0.5.0/24"
}

variable "cidr_vpc" {
  type        = string
  description = "The CIDR block to use for the VPC"
  default     = "10.0.0.0/16"
}

variable "platform_instance_id" {
  type        = string
  description = "A human-readable string for this instance of the GrayMeta Platform"
}
