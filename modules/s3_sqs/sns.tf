data "aws_sqs_queue" "queue" {
  name = element(split("/", var.queue_name), length(split("/", var.queue_name)) - 1)
}

resource "aws_sns_topic" "topic" {
  name = "GrayMetaPlatform-${var.platform_instance_id}-s3notifications-${data.aws_s3_bucket.bucket.id}"
}

resource "aws_sns_topic_subscription" "sqs_target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "sqs"
  endpoint  = data.aws_sqs_queue.queue.arn
}
