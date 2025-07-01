module "ec2_frontend_instance" {
  source = "./modules/ec2_frontend"
  ami_front_id = var.ami_front_id
  security_group_id = module.my_sg.security_group_id
}

module "sg_frontend" {
  source  = "./modules/security_group"
  puertos = [22, 5173]
}

module "sg_backend" {
  source  = "./modules/security_group"
  puertos = [22, 5000]
}