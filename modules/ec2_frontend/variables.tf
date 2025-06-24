variable "ami_front_id" {
  description = "AMI ID for the frontend server"
  type        = string
}
variable "security_group_id" {
  description = "Security Group ID to associate with the frontend instance"
  type        = string
}