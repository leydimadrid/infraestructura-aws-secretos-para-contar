module "ec2_backend_instance" {
    source = "./modules/ec2_backend"
}

module "ec2_frontend_instance" {
  source = "./modules/ec2_frontend"
}

module "my_sg" {
  source = "./modules/security_group"
}