output "elasticsearch_nsg" {
  value = aws_security_group.elasticsearch.id
}
