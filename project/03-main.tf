## ---------------------------------------------------------------------------------------------------------------------
## Project Daylily - Main 
## Modification History:
##   - 1.0.0    Jun 15,2023   -- Initial Version
## This project will deploy the following resources:

## A Lambda function for seeding the DynamoDB table
## An Amazon SQS queue
## A SNS Topic with email subscription
## Five CloudWatch Alarms
## A DynamoDB table
## A Step Function
## ---------------------------------------------------------------------------------------------------------------------


## SNS Topic with subscription
module "daylily_sns" {
  source                 = "../modules/sns"
  project_name           = var.project_name
  environment_name       = var.environment_name
  sns_topic_base_name    = var.sns_topic_base_name
  sns_topic_display_name = var.sns_topic_display_name
  kms_key_alias          = var.kms_key_alias
  sns_subscription_email = var.sns_subscription_email
}

## Step Function IAM Role
module "daylily_iam_role" {
  source              = "../modules/iam-role"
  project_name        = var.project_name
  environment_name    = var.environment_name
  sf_iam_role_name    = var.sf_iam_role_name
  sf_iam_policy_name  = var.sf_iam_policy_name
  sns_topic_base_name = var.sns_topic_base_name
  kms_key_arn         = var.kms_key_arn
}

## State Machine
module "daylily_step_function" {
  source           = "../modules/step-function"
  project_name     = var.project_name
  environment_name = var.environment_name
  sf_iam_role_arn  = module.daylily_iam_role.sf_iam_role_arn
  sns_topic_arn    = module.daylily_sns.sns_topic_arn
}
