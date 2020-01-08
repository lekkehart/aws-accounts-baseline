variable "default_region" {
  description = "The default region which is provisioned by this module."
  default     = "eu-west-1"
}

locals {
  terraform_tags = {
    created_by          = "terraform"
    project             = "aws-accounts-baseline"
    terraform_workspace = terraform.workspace
  }

  aws_account_id   = var.aws_account_ids[terraform.workspace]
  workspace_config = var.workspace_configs[terraform.workspace]
}

variable "audit_cloudtrail_kms_key_arn" {
  description = "The ARN of the KMS key used for encrypting CloudTrail events."
  default     = "arn:aws:kms:eu-west-1:545382763667:key/b8550b1e-6e50-47eb-b4d5-11a59aea3a8d"
}

variable "audit_cloudtrail_s3_bucket_name" {
  description = "The name of the S3 bucket used for storing CloudTrail events."
  default     = "audit-account-eu-west-1-log"
}
