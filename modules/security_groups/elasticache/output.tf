output "elasticache_nsg" {
  value = aws_security_group.elasticache.id
}
