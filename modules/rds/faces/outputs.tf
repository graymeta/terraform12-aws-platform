output "rds_database_name" {
  value = aws_rds_cluster.postgresql.database_name
}

output "faces_endpoint" {
  value = aws_rds_cluster.postgresql.endpoint
}
