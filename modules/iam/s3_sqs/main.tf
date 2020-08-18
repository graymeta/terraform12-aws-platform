data "aws_iam_policy_document" "sns-topic-policy" {
  statement {
    actions = [
      "SNS:Publish",
    ]

    condition {
      test     = "ArnEquals"
      variable = "AWS:SourceARN"

      values = [
        data.aws_s3_bucket.bucket.arn,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.topic.arn,
    ]

    sid = "allow_publish"
  }

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:Receive",
    ]

    condition {
      test     = "StringLike"
      variable = "SNS:Endpoint"

      values = [
        aws_sns_topic.topic.arn,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      data.aws_sqs_queue.queue.arn,
    ]

    sid = "allow_subscription"
  }
}

data "aws_iam_policy_document" "sqs-policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SQS:SendMessage",
    ]

    condition {
      test     = "ArnEquals"
      variable = "AWS:SourceARN"

      values = [
        aws_sns_topic.topic.arn,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      data.aws_sqs_queue.queue.arn,
    ]
  }
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.topic.arn
  policy = data.aws_iam_policy_document.sns-topic-policy.json
}

resource "aws_sqs_queue_policy" "sqs-policy" {
  queue_url = data.aws_sqs_queue.queue.id
  policy    = data.aws_iam_policy_document.sqs-policy.json
}
