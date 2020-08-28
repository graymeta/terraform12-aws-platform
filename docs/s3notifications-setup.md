# Setting up s3 ObjectCreated notifications

## Prerequisites:

* An S3 bucket's ARN

## Procedure:

Assume we want to set up notifications for the bucket with ARN `arn:aws:s3:::somebucket` and only trigger notifications from the `logs/` prefix that have the `.txt` suffix.

Add this block to your Terraform code:

```
resource "aws_sqs_queue" "my_notification_queue" {
    name = "my-notifications-queue"
}

module "s3_sqs" {
    source = "github.com/graymeta/terraform12-aws-platform//modules/s3_sqs"

    platform_instance_id = "${var.platform_instance_id}"
    region               = "${var.region}"
    
    bucket_arn           = "arn:aws:s3:::somebucket"
    queue_name           = "${aws_sqs_queue.my_notification_queue.id}"
    filter_prefix        = "logs/"
    filter_suffix        = ".txt"
}
```

* `platform_instance_id` - (string) - unique identifier for this instance of the platform
* `region` - (string) - AWS region
* `bucket_arn` - (string) - The ARN of the bucket to monitor
* `queue_name` - (string) - The name of the SQS queue to put the notifications into
* `filter_prefix` - (string) - Optional. The prefix that the s3 keys must match to trigger a notification. Leave blank if you want all items in the bucket to trigger notifications.
* `filter_suffix` - (string) - Optional. The suffix that the s3 keys must match to trigger a notification. Leave blank if you want all items in the bucket to trigger notifications.


# Triggering harvests via S3 ObjectCreated notifications

## Prerequisite:

* S3 bucket configured with notifications for ObjectCreated\* events that get published to an SQS queue. If you do not have this set up already, see [here](s3notifications-setup.md)
* S3 bucket has been added as a storage location inside the GrayMeta Platform and the container is toggled into the `enabled` state.

## Configuration

Set the following variables to `terraform.tfvars` when instantiating the module:

```
# (Optional) S3 notification
# https://github.com/graymeta/terraform12-aws-platform/blob/master/docs/s3notifications-setup.md
s3subscriber_priority   = 2
sqs_s3notifications_arn = "arn of the queue"
sqs_s3notifications     = "name of the queue"
}
```

* `sqs_s3notifications_arn` - (string) - The ARN of the SQS queue that the s3 ObjectCreated notifications will be read from
* `sqs_s3notifications` - (string) - The https endpoint of the SQS queue that the s3 ObjectCreated notifications will be read from
* `s3subscriber_priority` - (integer) - Optional. The priority to assign harvest jobs being scheduled from s3 ObjectCreated notifications. Valid values are 1 through 10 (1=highest priority). If not set, uses the platform default priority level (5).