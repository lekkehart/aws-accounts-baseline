terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket         = "ekklot-org-eu-west-1-terraform-state"
    key            = "aws-accounts-baseline.tfstate"
    region         = "eu-west-1"
    encrypt        = "true"
    dynamodb_table = "ekklot-org-eu-west-1-terraform-state-lock"
  }
}

# ------------------------------------------------------------
# Default provider
# ------------------------------------------------------------
provider "aws" {
  region  = var.default_region
  version = "~> 2.43"

  assume_role {
    role_arn     = terraform.workspace == "test2" ? "" : "arn:aws:iam::${local.aws_account_id}:role/OrganizationAccountAccessRole"
    session_name = "SESSION_NAME"
    external_id  = "EXTERNAL_ID"
  }
}

# ------------------------------------------------------------
# Other providers
# ------------------------------------------------------------
provider "aws" {
  alias   = "eu-central-1"
  region  = "eu-central-1"
  version = "~> 2.43"

  assume_role {
    role_arn     = terraform.workspace == "test2" ? "" : "arn:aws:iam::${local.aws_account_id}:role/OrganizationAccountAccessRole"
    session_name = "SESSION_NAME"
    external_id  = "EXTERNAL_ID"
  }
}
