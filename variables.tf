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

variable "git_repo_url" {                   
  description = "URL del repositorio Git a clonar"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "region" {                   
  description = "Región de AWS donde se desplegará la instancia EC2"
}

variable "key_name" {
  description = "Nombre de la llave SSH"
}

variable "region" {                   
  description = "Región de AWS donde se desplegará la instancia EC2"
}

