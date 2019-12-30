variable "region" {
  description = "The region used for the AWS provider."
}

variable "terraform_tags" {
  description = "The map of default tags which is used for tagging resources created by this script."
  type        = map(string)
}

variable "aws_account_id" {
  type = string
}

variable "module_config" {
  type = map(string)
}
