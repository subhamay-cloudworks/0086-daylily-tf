## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - IAM Execution Role Module
## Modification History:
##   - 1.0.0    Jun 15,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

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
  default     = ""
}

variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = map(string)
  default = {
    "us-east-1" = "arn:aws:kms:us-east-1:807724355529:key/e4c733c5-9fbe-4a90-bda1-6f0362bc9b89"
  }
}
######################################## SNS Topic #################################################
variable "sns_topic_base_name" {
  description = "The base name of the SNS Topic"
  type        = string
  default     = "sns-topic"
}
######################################## IAM Role / Policy #########################################
variable "sf_iam_role_name" {
  description = "The name of the Step Function IAM Role"
  type        = string
  default     = "step-function-iam-role"
}

variable "sf_iam_policy_name" {
  description = "The name of the Step Function IAM Policy"
  type        = string
  default     = "step-function-iam-policy"
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  sns_topic_name = "${var.project_name}-${var.sns_topic_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  sf_iam_role_name = "${var.project_name}-${var.sf_iam_role_name}"
}

locals {
  sf_iam_policy_name = "${var.project_name}-${var.sf_iam_policy_name}"
}