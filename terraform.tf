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
  region = var.region
}

resource "aws_key_pair" "default" {
  key_name   =  var.key_name
  public_key = file("${path.module}/backend-key.pub")
}