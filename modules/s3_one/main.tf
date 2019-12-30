resource "aws_s3_bucket" "s3_bucket" {
  count  = var.module_config["s3_bucket"] == "yes" ? 1 : 0

  bucket = "ekklot-one-${var.region}-${var.aws_account_id}"

  acl = "private"

  tags   = var.terraform_tags
  region = var.region
}

resource "aws_s3_bucket" "s3_bucket_1" {
  count  = var.module_config["s3_bucket_1"] == "yes" ? 1 : 0

  bucket = "ekklot-one-1-${var.region}-${var.aws_account_id}"

  acl = "private"

  tags   = var.terraform_tags
  region = var.region
}
