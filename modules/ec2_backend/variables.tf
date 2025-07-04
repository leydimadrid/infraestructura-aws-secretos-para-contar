variable "ami_back_id" {
  description = "AMI ID for the backend server"
  type        = string
}
variable "security_group_id" {
  description = "Security Group ID to associate with the backend instance"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "region" {                   
  description = "Región de AWS donde se desplegará la instancia EC2"
}

