output "faces_endpoint" {
  value = "${var.mlservices_alb_dns}:${local.api_port}"
}
