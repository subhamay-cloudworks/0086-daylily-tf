## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - Project Daylily
## Modification History:
##   - 1.0.0    Jun 15,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

data "aws_region" "current" {}
######################################## Project Name ##############################################
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "project"
}
######################################## Environment Name ##########################################
variable "environment_name" {
  type        = string
  description = <<EOT
  (Optional) The environment in which to deploy our resources to.

  Options:
  - devl : Development
  - test: Test
  - prod: Production

  Default: devl
  EOT
  default     = "devl"

  validation {
    condition     = can(regex("^devl$|^test$|^prod$", var.environment_name))
    error_message = "Err: environment is not valid."
  }
}
######################################## KMS Key ###################################################
variable "kms_key_alias" {
  description = "KMS Key Alias"
  type        = string
}
variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = map(string)
  default = {
    "region-name" = "kms-key-arn"
  }
}
######################################## SNS Topic #################################################
variable "sns_topic_base_name" {
  description = "The base name of the SNS Topic"
  type        = string
}

variable "sns_topic_display_name" {
  description = "The display name of the SNS Topic"
  type        = string
}
######################################## SNS Topic Subscription ####################################
variable "sns_subscription_email" {
  description = "The SNS subscription email"
  type        = list(string)
  default     = ["someone@email.com"]
}
######################################## Lambda IAM Role / Policy ##################################
variable "sf_iam_role_name" {
  description = "The name of the State Machine IAM Role"
  type        = string
}

variable "sf_iam_policy_name" {
  description = "The name of the Step Function IAM Policy"
  type        = string
}
