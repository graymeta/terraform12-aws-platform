output "endpoint" {
  value = "http://${var.mlservices_alb_dns}:${var.port}"
}
