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

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "region" {                   
  description = "Región de AWS donde se desplegará la instancia EC2"
}