variable "puertos" {
  description = "Lista de puertos que se permitirán en el Security Group"
  type        = list(number)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}