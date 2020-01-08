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
