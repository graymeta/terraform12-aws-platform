output "faces_endpoint" {
  value = "http://${var.mlservices_alb_dns}:${local.api_port}"
}
