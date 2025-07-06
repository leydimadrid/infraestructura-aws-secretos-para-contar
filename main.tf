module "ec2_frontend_instance" {
  source = "./modules/ec2_frontend"
  ami_front_id = var.ami_front_id
  instance_type = var.instance_type
  security_group_id = module.sg_frontend.security_group_id
}

module "ec2_backend_instance" {
  source = "./modules/ec2_backend"
  ami_back_id = var.ami_back_id
  instance_type = var.instance_type
  security_group_id = module.sg_backend.security_group_id
  region = var.region
} 
  
module "sg_frontend" {
  source  = "./modules/security_group"
  puertos = [22, 5173, 3000]
}

module "sg_backend" {
  source  = "./modules/security_group"
  puertos = [22, 5000, 5432]
}


module "rds_postgres" {
  source               = "./modules/rds_postgres"
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  db_instance_class    = var.db_instance_class
  engine_version       = var.engine_version
  subnet_ids           = ["subnet-98d566f3", "subnet-bce40dc1"]
  security_group_id = module.sg_backend.security_group_id
}
