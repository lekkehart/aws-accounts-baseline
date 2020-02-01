# --------------------------------------------------------------------------------------------------
# CloudTrail Baseline
# --------------------------------------------------------------------------------------------------
module "cloudtrail_baseline" {
  source = "./cloudtrail-baseline"

  aws_account_id                  = var.aws_account_id
  region                          = var.default_region
  audit_cloudtrail_kms_key_arn    = var.audit_cloudtrail_kms_key_arn
  audit_cloudtrail_s3_bucket_name = var.audit_cloudtrail_s3_bucket_name
  terraform_tags                  = var.terraform_tags
}

# --------------------------------------------------------------------------------------------------
# CloudWatch Alarms Baseline
# --------------------------------------------------------------------------------------------------
module "alarm_baseline" {
  source = "./alarm-baseline"

  alarm_namespace           = "${var.alarm_namespace}"
  cloudtrail_log_group_name = "${module.cloudtrail_baseline.log_group_name}"
  sns_topic_name            = "${var.alarm_sns_topic_name}"
}
