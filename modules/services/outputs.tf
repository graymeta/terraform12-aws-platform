output "services_asg" {
  value = "${aws_cloudformation_stack.services_asg.outputs["AsgName"]}"
}
