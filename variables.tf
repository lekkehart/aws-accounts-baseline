variable "default_region" {
  description = "The default region which is provisioned by this module."
  default     = "eu-west-1"
}

variable "aws_account_ids" {
  type        = map(string)
  description = "Map of AWS Account ID numbers. The key is the workspace name."

  default = {
    test2-group1-dev = "025262048239"
    test2-group2-dev = "323133235112"
  }
}

variable "workspace_configs" {
  type        = map(map(map(string)))
  description = "Map of configurations per workspace & module. The key is the workspace name. Subkey is the module name."

  default = {
    // workspace name
    test2-group1-dev = {
      // module name
      s3_one = {
        // config parameters
        s3_bucket   = "no"
        s3_bucket_1 = "no"
      }
      s3_two = {
        s3_bucket = "no"
      }
    }
    test2-group2-dev = {
      s3_one = {
        s3_bucket   = "yes"
        s3_bucket_1 = "no"
      }
      s3_two = {
        s3_bucket = "yes"
      }
    }
  }
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
