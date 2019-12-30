variable "aws_account_id" {
  description = "The AWS Account ID number of the account."
}

variable "cloudtrail_name" {
  description = "The name of the trail."
  default     = "cloudtrail-multi-region"
}

variable "cloudwatch_logs_group_name" {
  description = "The name of CloudWatch Logs group to which CloudTrail events are delivered."
  default     = "cloudtrail-multi-region"
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely."
  default     = 365
}

variable "iam_role_name" {
  description = "The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  default     = "CloudTrail-CloudWatch-Delivery-Role"
}

variable "iam_role_policy_name" {
  description = "The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  default     = "CloudTrail-CloudWatch-Delivery-Policy"
}

variable "region" {
  description = "The AWS region in which CloudTrail is set up."
}

variable "audit_cloudtrail_kms_key_arn" {
  description = "The ARN of the KMS key used for encrypting CloudTrail events."
}

variable "audit_cloudtrail_s3_bucket_name" {
  description = "The name of the S3 bucket used for storing CloudTrail events."
}

variable "cloudtrail_s3_bucket_key_prefix" {
  description = "The prefix used when writing CloudTrail into the S3 bucket."
  default     = "cloudtrail"
}

variable "terraform_tags" {
  description = "The map of default tags which is used for tagging resources created by this script."
  type = map(string)
}
