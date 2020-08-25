variable "apply_immediately" {
  type        = bool
  description = "Apply database modifications immediately, or during the next maintenance window."
}

variable "instance_count" {
  type        = number
  description = "The number of RDS cluster instances."
  default     = 2
}

variable "platform_instance_id" {
  type        = string
  description = "A human-readable string for this instance of the GrayMeta Platform"
}

variable "rds_asg_target_cpu" {
  type        = number
  description = "RDS ASG target CPU"
  default     = 80
}

variable "rds_asg_scalein_cooldown" {
  type        = number
  description = "RDS ASG Scale In cooldown"
  default     = 300
}

variable "rds_asg_scaleout_cooldown" {
  type        = number
  description = "RDS ASG Scale Out cooldown"
  default     = 300
}

variable "rds_asg_max_capacity" {
  type        = number
  description = "RDS max number of read nodes"
  default     = 15
}

variable "rds_backup_retention" {
  type        = number
  description = "The days to retain backups for."
}

variable "rds_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created. Time in UTC. e.g. e.g. 04:00-09:00"
}

variable "rds_database_name" {
  type        = string
  description = "The database name to deploy"
}

variable "rds_instance_size" {
  type        = string
  description = "The instance class to use. Aurora uses db.* instance classes/types."
}

variable "rds_kms_key_id" {
  type        = string
  description = "The ARN for the KMS encryption key. When specifying kms_key_id, rds_storage_encrypted needs to be set to true."
}

variable "rds_nsg" {
  type        = string
  description = "RDS network security group."
}

variable "rds_password" {
  type        = string
  description = " Password for the master DB user."
}

variable "rds_snapshot" {
  type = string
}

variable "rds_storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB cluster is encrypted."
}

variable "rds_subnet_group_name" {
  type        = string
  description = "RDS subnet group name."
}

variable "rds_username" {
  type        = string
  description = "The master username for the database"
}

variable "rds_version" {
  type        = string
  description = "The database engine version."
}
