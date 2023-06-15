## ---------------------------------------------------------------------------------------------------------------------
## Step Function - Main 
## Modification History:
##   - 1.0.0    Jun 15,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------


resource "aws_sfn_state_machine" "daylily-step-function" {
  name       = local.step_function_name
  role_arn   = var.sf_iam_role_arn
  definition = local.definition_template

  tags = local.tags
}