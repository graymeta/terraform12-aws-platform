variable "dns_name" { type = string }
variable "key_name" { type = string }
variable "platform_instance_id" { type = string }
variable "proxy_ami_id" { type = string }
variable "proxy_iam_instance_profile" { type = string }

variable "proxy_instance_type" {
  type        = string
  description = "The instance type to use for proxy nodes"
  default     = "m3.large"
}

variable "proxy_max_cluster_size" { type = number }
variable "proxy_min_cluster_size" { type = number }
variable "proxy_nsg" { type = string }

variable "proxy_scale_down_evaluation_periods" {
  type        = number
  description = "The scale down evaluation periods.  Default 4"
  default     = 4
}

variable "proxy_scale_down_period" {
  type        = number
  description = "The scale down period.  Default 300"
  default     = 300
}

variable "proxy_scale_down_thres" {
  type        = number
  description = "Threshold in Bytes when to scale down the proxy cluster"
}

variable "proxy_scale_up_evaluation_periods" {
  type        = number
  description = "The scale up evaluation periods.  Default 2"
  default     = 2
}

variable "proxy_scale_up_period" {
  type        = number
  description = "The scale up period.  Default 120"
  default     = 120
}

variable "proxy_scale_up_thres" {
  type        = number
  description = "Threshold in Bytes when to scale up the proxy cluster"
}

variable "proxy_subnet_id_1" { type = string }
variable "proxy_subnet_id_2" { type = string }

variable "proxy_user_init" {
  type        = string
  description = "Custom cloud-init that is rendered to be used on proxy instances. (Not Recommened)"
  default     = ""
}

variable "safelist" {
  type        = list(string)
  description = "List of dstdomain to add to the proxy server.  Please talk to Graymeta Support before changing"

  default = [
    ".amazonaws.com",
    ".box.com",
    ".boxcloud.com",
    ".cognitive.microsoft.com",
    ".cognitive.microsoft.com",
    ".core.windows.net",
    ".curio.app",
    ".darksky.net",
    ".digitaloceanspaces.com",
    ".dropboxapi.com",
    ".forecast.io",
    ".geonames.org",
    ".googleapis.com",
    "graph.microsoft.com",
    ".graymeta.com",
    ".kairos.com",
    ".logograb.com",
    ".microsoftonline.com",
    ".okta.com",
    ".picpurify.com",
    ".platform.bing.com",
    ".speech.microsoft.com",
    ".speechmatics.com",
    ".valossa.com",
    ".voicebase.com",
    ".watsonplatform.net",
  ]
}

variable "target_group_3128_arn" { type = string }
