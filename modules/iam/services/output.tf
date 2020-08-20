output "services_iam_instance_profile" {
  value = aws_iam_instance_profile.iam_instance_profile_services.name
}

output "services_iam_role_name" {
  value = aws_iam_role.iam_role.name
}
