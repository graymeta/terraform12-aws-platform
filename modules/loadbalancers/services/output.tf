output "services_endpoint" {
  value = aws_lb.services_alb.dns_name
}

output "target_group_7000_arn" {
  value = aws_lb_target_group.port7000.arn
}

output "target_group_7009_arn" {
  value = aws_lb_target_group.port7009.arn
}

output "services_alb_cw" {
  value = "${aws_lb.services_alb.arn_suffix}"
}
