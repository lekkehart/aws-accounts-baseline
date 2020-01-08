# aws-accounts-baseline

Purpose of this experimental project is to test provisioning of a baseline of AWS features onto a list of AWS accounts.

It is assumed the steps in [aws-accounts](https://github.com/lekkehart/aws-accounts) have been run before:
* The Terraform backend (S3 + DynamoDB) has been created in the organization master account. 
  Terraform state files are stored centrally in the organization master account, i.e. even for all the child accounts 
  of the AWS organization. 
* The new AWS account has been created underneath the AWS organization.
* The `audit_cloudtrail_s3_bucket_name` S3 bucket in the `audit` account has been provisioned as such
  that the newly created AWS accounts are allowed to send their CloudTrails to it.

The project demonstrates:
* A set of baseline features is rolled out to a set of AWS accounts:
  *  Module [s3_one](modules/s3_one/main.tf).
  *  Module [s3_two](modules/s3_two/main.tf).
  *  Module [cloudtrail-baseline](modules/security-baseline/cloudtrail-baseline/main.tf).
* The map structure `workspace_configs` in [workspace_configs.tf](workspace_configs.tf) controls which features are to be enabled in 
  which accounts. 
* It uses Terraform's `workspace` feature which creates a separate `tfstate` file for each AWS account.
  This reduces blast radius and allows to apply changes initially to a single AWS account before rolling it out to all
  of them.
* Terraform is run with an IAM user into the AWS organization account which then assumes the 
  `OrganizationAccountAccessRole` in order to provision the respective sub accounts, see [providers.tf](providers.tf)
* [Makefile](Makefile) and [run_terraform.sh](run_terraform.sh) implement a mechanism to roll out the baseline to all 
  workspaces. 
* Demonstrates how to provision resources in multiple AWS regions, see [modules/s3_two](modules/s3_two/main.tf).

Above all, the project gives a feeling for what changes are required whenever a new AWS account is added.

## Workflow for adding a new AWS account

Let's add the following AWS account to the list of accounts on which we want to deploy a baseline:
* AWS account name: `test2+xxx+yyy`
* AWS account ID: `123456789012`

### Pre-requisite

Above account has been created by means of [aws-accounts](https://github.com/lekkehart/aws-accounts) which provided the 
following output:

    ```
    aws_accounts = [
      {
        "arn" = ...
        "email" = ...
        "id" = 123456789012
        "name" = test2+xxx+yyy
      },
      ...
    ]
    ```

### Steps

_NOTE!: Terraform workspace names must not include `+`. Therefore, use `-` instead of the `+`, i.e. `test2-xxx-yyy`._

1. Create terraform workspace for account

    [Terraform Workspaces](https://www.terraform.io/docs/commands/workspace/index.html) 
    is the mechanism we use for applying the same set of terraform scripts onto a list of AWS accounts.
    
    Workspaces map to AWS accounts here.
    
    Create a workspace for the new account. Otherwise, the Travis pipeline will fail. 
    
    ```
    $ terraform.exe workspace new test2-xxx-yyy
    Created and switched to workspace "test2-xxx-yyy"!
    
    You're now on a new, empty workspace. Workspaces isolate their state,
    so if you run "terraform plan" Terraform will not see any existing state
    for this configuration.
    ```
  
1. Add account to [run_terraform.sh](run_terraform.sh)

    `run_terraform.sh` is used by the Travis pipelines for looping over all AWS accounts.

    ```
    WORKSPACES=(
      ...
      test2-xxx-yyy
      ...
    )
    ```

1. Add account to [workspace_configs.tf](workspace_configs.tf) - variable `aws_account_ids`

    Add account and respective account ID which was received as output from [aws-config](https://github.com/ekklot/aws-config).

    ```
    variable "aws_account_ids" {
      type        = map(string)
      description = "Map of AWS Account ID numbers. The key is the workspace name."
    
      default = {
        ...
        test2+xxx+yyy = 123456789012      
        ...
      }
    }
    ```

1. Add account to [workspace_configs.tf](workspace_configs.tf) - variable `workspace_configs`

    Add the account specific configuration, e.g. enable/disable functionality in the modules.

    ```
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
        ...
        }
      }
    }
    ```


   
1. Run `make`

    ```
    make validate
    make plan
    make apply
   
    ```
   

## Terraform State

There is a separate terraform state file in S3 for each workspace. 
Terraform state files are stored in the S3 bucket of the organization master account.

For example:
```
# account test2-group1-dev
https://ekklot-org-eu-west-1-terraform-state.s3-eu-west-1.amazonaws.com/env%3A/test2-group1-dev/aws-accounts-baseline.tfstate
```
