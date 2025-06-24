output "security_group_id" {
  description = "ID del Security Group creado"
  value       = aws_security_group.security_group.id
}