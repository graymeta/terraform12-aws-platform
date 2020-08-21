resource "aws_iam_policy" "iam_policy" {
  description = "GrayMeta Platform ML Nodes privileges"
  name        = "GrayMetaPlatform-${var.platform_instance_id}-ML-Policy"
  policy      = data.template_file.policy_ml.rendered
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = aws_iam_policy.iam_policy.name
  policy_arn = aws_iam_policy.iam_policy.arn
  roles      = [aws_iam_role.iam_role.name]
}

resource "aws_iam_instance_profile" "iam_instance_profile_mlservices" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-ML-InstanceProfile"
  role = aws_iam_role.iam_role.name
}

data "template_file" "policy_ml" {
  template = file("${path.module}/policy-ml.json.tpl")
}

resource "aws_iam_role" "iam_role" {
  name               = "GrayMetaPlatform-${var.platform_instance_id}-ML-AssumeRole"
  assume_role_policy = file("${path.module}/policy-assume-role.json")
}
