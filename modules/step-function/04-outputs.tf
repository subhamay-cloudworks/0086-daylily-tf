## ---------------------------------------------------------------------------------------------------------------------
## Output - Step Function Module
## Modification History:
##   - 1.0.0    Jun 15,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

output "step_function_arn" {
  value = aws_sfn_state_machine.daylily-step-function.arn
}