module "ec2_frontend_instance" {
  source = "./modules/ec2_frontend"
  ami_front_id = var.ami_front_id
  security_group_id = module.my_sg.security_group_id
}

module "ec2_backend_instance" {
  source = "./modules/ec2_backend"
  ami_back_id = var.ami_back_id
  instance_type = var.instance_type
  key_name = var.key_name
  git_repo_url = var.git_repo_url
  security_group_id = module.my_sg.security_group_id
  region = var.region
} 
  
module "sg_frontend" {
  source  = "./modules/security_group"
  puertos = [22, 5173]
}

module "sg_backend" {
  source  = "./modules/security_group"
  puertos = [22, 5000]
}