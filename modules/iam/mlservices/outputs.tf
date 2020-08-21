output "mlservices_iam_instance_profile" {
  value = aws_iam_instance_profile.iam_instance_profile_mlservices.name
}

output "mlservices_iam_role_name" {
  value = aws_iam_role.iam_role.name
}
