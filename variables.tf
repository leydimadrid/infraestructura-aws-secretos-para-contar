variable "ami_back_id" {
  description = "AMI ID for the backend server"
  type        = string
}

variable "ami_front_id" {
  description = "AMI ID for the frontend server"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}