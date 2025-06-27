terraform {
  backend "s3" {
    bucket = "terraform-nodo"
    key    = "grupo3/terraform.tfstate"
    region = "us-east-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
    required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
}