output "endpoint" {
  value = "${aws_rds_cluster_endpoint.static.endpoint}"
}