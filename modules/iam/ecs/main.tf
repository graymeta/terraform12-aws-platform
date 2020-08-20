resource "aws_iam_role" "ecs" {
  name               = "GrayMetaPlatform-${var.platform_instance_id}-ECS-AssumeRole"
  assume_role_policy = file("${path.module}/policy-assume-role.json")
}

data "aws_s3_bucket" "temp" {
  bucket = var.temp_bucket
}

data "template_file" "policy_ecs" {
  template = file("${path.module}/policy-ecs.json.tpl")

  vars = {
    bucket_arn = data.aws_s3_bucket.temp.arn
  }
}

resource "aws_iam_policy" "ecs" {
  name        = "GrayMetaPlatform-${var.platform_instance_id}-ECS-Policy"
  description = "GrayMeta Platform ECS privileges"
  policy      = data.template_file.policy_ecs.rendered
}

resource "aws_iam_policy_attachment" "ecs" {
  name       = aws_iam_policy.ecs.name
  roles      = [aws_iam_role.ecs.name]
  policy_arn = aws_iam_policy.ecs.arn
}

resource "aws_iam_instance_profile" "ecs" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-ECS-InstanceProfile"
  role = aws_iam_role.ecs.name
}
