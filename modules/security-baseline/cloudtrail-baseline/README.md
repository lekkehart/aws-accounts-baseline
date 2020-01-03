# cloudtrail-baseline

Enable CloudTrail in all regions and deliver events to CloudWatch Logs. CloudTrail logs are encrypted using AWS Key Management Service.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_account_id | The AWS Account ID number of the account. | string | - | yes |
| cloudtrail_name | The name of the trail. | string | `cloudtrail-multi-region` | no |
| cloudwatch_logs_group_name | The name of CloudWatch Logs group to which CloudTrail events are delivered. | string | `cloudtrail-multi-region` | no |
| cloudwatch_logs_retention_in_days | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | string | `365` | no |
| iam_role_name | The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group. | string | `CloudTrail-CloudWatch-Delivery-Role` | no |
| iam_role_policy_name | The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group. | string | `CloudTrail-CloudWatch-Delivery-Policy` | no |
| region | The AWS region in which CloudTrail is set up. | string | - | yes |
| audit_cloudtrail_kms_key_arn | The ARN of the KMS key used for encrypting CloudTrail events. | string | - | yes |
| audit_cloudtrail_s3_bucket_name | The name of the S3 bucket used for storing CloudTrail events. | string | - | yes |
| cloudtrail_s3_bucket_key_prefix | The prefix used when writing CloudTrail into the S3 bucket. | string | `cloudtrail` | no |
| terraform_tags | The map of default tags which is used for tagging resources created by this script. | map | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| log_delivery_iam_role_arn | The ARN of the IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| log_delivery_iam_role_name | The name of the IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| log_group_arn | The ARN of the CloudWatch Logs log group which stores CloudTrail events. |
| log_group_name | The name of the CloudWatch Logs log group which stores CloudTrail events. |
