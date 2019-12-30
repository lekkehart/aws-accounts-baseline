data "aws_region" "current" {}

resource "aws_s3_bucket" "s3_bucket" {
  count  = var.module_config["s3_bucket"] == "yes" ? 1 : 0

  bucket = "ekklot-two-${data.aws_region.current.name}-${var.aws_account_id}"

  acl = "private"

  tags   = var.terraform_tags
  region = data.aws_region.current.name
}
