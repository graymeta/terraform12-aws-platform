output "mlservices_nsg" {
  value = aws_security_group.mlservices.id
}

output "faces_nsg" {
  value = aws_security_group.rds.id
}