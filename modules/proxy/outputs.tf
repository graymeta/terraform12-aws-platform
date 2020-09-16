output "proxy_asg" {
  value = aws_cloudformation_stack.proxy_asg.outputs["AsgName"]
}
