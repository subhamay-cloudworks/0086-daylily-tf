## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - State Machine Module
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
######################################## Step Function IAM Role ####################################
variable "sf_iam_role_arn" {
  description = "The Arn of the IAM role for the state machine."
  type        = string
  default     = ""
}
######################################## SNS Topic Arn #############################################
variable "sns_topic_arn" {
  description = "The Arn of SNS Topic."
  type        = string
  default     = ""
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  step_function_name = "${var.project_name}-state-machine-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  definition_template = <<EOF
{
   "Comment":"A Step Function Demo using SNS (Simple Notification Service) and Wait state.",
   "TimeoutSeconds":3600,
   "StartAt":"Wait for Timestamp",
   "States":{
      "Wait for Timestamp":{
         "Type":"Wait",
         "Next":"Send SNS Message",
         "InputPath":"$",
         "SecondsPath":"$.waitSeconds",
         "OutputPath":"$.Message"
      },
      "Send SNS Message":{
         "Type":"Task",
         "Resource":"arn:aws:states:::sns:publish",
         "Parameters":{
            "Message":{
               "Message.$":"$"
            },
            "TopicArn":"${var.sns_topic_arn}"
         },
         "End":true
      }
   }
}
EOF
}
