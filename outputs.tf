output "rds_endpoint" {
  value = module.rds_postgres.endpoint
}

output "backend_public_ip" {
  value = module.ec2_backend_instance.backend_public_ip
}
