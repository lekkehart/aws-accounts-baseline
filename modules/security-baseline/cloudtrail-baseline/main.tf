# --------------------------------------------------------------------------------------------------
# CloudWatch Logs group to accept CloudTrail event stream.
# --------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "cloudtrail_events" {
  name              = var.cloudwatch_logs_group_name
  tags              = var.terraform_tags
  retention_in_days = var.cloudwatch_logs_retention_in_days
}

# --------------------------------------------------------------------------------------------------
# IAM Role to deliver CloudTrail events to CloudWatch Logs group.
# The policy was derived from the default key policy descrived in AWS CloudTrail User Guide.
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/send-cloudtrail-events-to-cloudwatch-logs.html
# --------------------------------------------------------------------------------------------------
resource "aws_iam_role" "cloudwatch_delivery" {
  name = var.iam_role_name

  assume_role_policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
END_OF_POLICY
}

resource "aws_iam_role_policy" "cloudwatch_delivery_policy" {
  name = var.iam_role_policy_name

  role = aws_iam_role.cloudwatch_delivery.id

  policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailCreateLogStream2014110",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream"
      ],
      "Resource": [
        "arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:${aws_cloudwatch_log_group.cloudtrail_events.name}:log-stream:*"
      ]

    },
    {
      "Sid": "AWSCloudTrailPutLogEvents20141101",
      "Effect": "Allow",
      "Action": [
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:${aws_cloudwatch_log_group.cloudtrail_events.name}:log-stream:*"
      ]
    }
  ]
}
END_OF_POLICY
}

# --------------------------------------------------------------------------------------------------
# CloudTrail configuration.
# --------------------------------------------------------------------------------------------------
resource "aws_cloudtrail" "global" {
  name                          = var.cloudtrail_name
  tags                          = var.terraform_tags

  cloud_watch_logs_group_arn    = aws_cloudwatch_log_group.cloudtrail_events.arn
  cloud_watch_logs_role_arn     = aws_iam_role.cloudwatch_delivery.arn
  enable_log_file_validation    = true
  include_global_service_events = true
  is_multi_region_trail         = true
  kms_key_id                    = var.audit_cloudtrail_kms_key_arn
  s3_bucket_name                = var.audit_cloudtrail_s3_bucket_name
  s3_key_prefix                 = var.cloudtrail_s3_bucket_key_prefix
}
