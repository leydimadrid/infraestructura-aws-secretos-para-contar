output "instance_public_ips" {
  value = aws_instance.my_instance.*.public_ip
}

