variable "aws_account_id" {
  description = "The ID of the AWS account which is provisioned by this module."
}

variable "default_region" {
  description = "The default region which is provisioned by this module."
}

variable "audit_cloudtrail_kms_key_arn" {
  description = "The ARN of the KMS key used for encrypting CloudTrail events."
}

variable "audit_cloudtrail_s3_bucket_name" {
  description = "The name of the S3 bucket used for storing CloudTrail events."
}

variable "terraform_tags" {
  description = "The map of default tags which is used for tagging resources created by this script."
  type = map
}

# --------------------------------------------------------------------------------------------------
# Variables for alarm-baseline module.
# --------------------------------------------------------------------------------------------------

variable "alarm_namespace" {
  description = "The namespace in which all alarms are set up."
  default     = "CISBenchmark"
}

variable "alarm_sns_topic_name" {
  description = "The name of the SNS Topic which will be notified when any alarm is performed."
  default     = "CISAlarm"
}
