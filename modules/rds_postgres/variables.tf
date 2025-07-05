variable "security_group_id" {
  description = "Security group ID for the database"
  type        = string
}

variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "db_instance_class" {}
variable "engine_version" {}
variable "subnet_ids" {
  type = list(string)
}
