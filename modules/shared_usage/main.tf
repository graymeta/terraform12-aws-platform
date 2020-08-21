data "aws_s3_bucket" "usage" {
  bucket = var.usage_bucket
}

data "template_file" "policy_usage" {
  template = file("${path.module}/policy-usage.json.tpl")

  vars {
    usage_bucket_arn = data.aws_s3_bucket.usage.arn
    graymeta_account = var.graymeta_account
  }
}

resource "aws_s3_bucket_policy" "usage" {
  bucket = var.usage_bucket
  policy = data.template_file.policy_usage.rendered
}
