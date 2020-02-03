# ------------------------------------------------------------
# Create S3 buckets
# ------------------------------------------------------------
module "s3_one" {
  source = "./modules/s3_one"

  region         = var.default_region
  terraform_tags = local.terraform_tags
  aws_account_id = local.aws_account_id
  module_config  = local.workspace_config["s3_one"]
}

module "s3_two" {
  source = "./modules/s3_two"

  providers = {
    aws = aws.eu-central-1
  }

  terraform_tags = local.terraform_tags
  aws_account_id = local.aws_account_id
  module_config  = local.workspace_config["s3_two"]
}

module "s3_two_1" {
  source = "./modules/s3_two"

  terraform_tags = local.terraform_tags
  aws_account_id = local.aws_account_id
  module_config  = local.workspace_config["s3_two"]
}

module "security_baseline" {
  source = "./modules/security-baseline"

  aws_account_id = local.aws_account_id
  default_region = var.default_region

  audit_cloudtrail_kms_key_arn    = var.audit_cloudtrail_kms_key_arn
  audit_cloudtrail_s3_bucket_name = var.audit_cloudtrail_s3_bucket_name
  terraform_tags                  = local.terraform_tags
}
