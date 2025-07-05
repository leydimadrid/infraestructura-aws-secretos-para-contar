output "instance_public_ips" {
  value = aws_instance.ec2_instance.*.public_ip
}

output "backend_public_ip" {
  value = aws_eip.backend_eip.public_ip
}
