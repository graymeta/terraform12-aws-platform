output "ecs_iam_instance_profile" {
  value = aws_iam_instance_profile.ecs.name
}

output "ecs_iam_role" {
  value = aws_iam_role.ecs.name
}
