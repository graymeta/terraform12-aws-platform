output "proxy_endpoint" {
  value = "${aws_lb.proxy_lb.dns_name}:3128"
}

output "target_group_3128_arn" {
  value = aws_lb_target_group.port3128.arn
}
