output "rds_database_name" {
  value = aws_rds_cluster.postgresql.database_name
}

output "rds_endpoint" {
  value = aws_rds_cluster.postgresql.endpoint
}
