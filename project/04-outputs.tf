## ---------------------------------------------------------------------------------------------------------------------
## Output - Project daylily
## Modification History:
##   - 1.0.0    Jun 15,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## SNS Topic #################################################
output "daylily_sns_topic_arn" {
  value = module.daylily_sns.sns_topic_arn
}

output "daylily_sns_topic_display_name" {
  value = module.daylily_sns.sns_topic_display_name
}

output "daylily_sns_topic_id" {
  value = module.daylily_sns.sns_topic_id
}

output "daylily_sns_topic_owner" {
  value = module.daylily_sns.sns_topic_owner
}

output "daylily_sns_topic_tags_all" {
  value = module.daylily_sns.sns_topic_tags_all
}
######################################## SNS Subscription ##########################################
output "daylily_sns_topic_subscription_arn" {
  value = module.daylily_sns.sns_topic_subscription_arn
}
######################################## Step Function IAM Role ####################################
output "daylily_sf_iam_role_arn" {
  value = module.daylily_iam_role.sf_iam_role_arn
}
######################################## Step Function #############################################
# output "daylily_step_function_arn" {
#   value = module.daylily_step_function.step_function_arn
# }
