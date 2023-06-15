## ---------------------------------------------------------------------------------------------------------------------
## IAM Role and Policy - Main 
## Modification History:
##   - 1.0.0    Jun 15,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------


######################################## State Machine IAM Role ####################################
resource "aws_iam_role" "sf-iam-role" {
  name        = local.sf_iam_role_name
  description = "Daylily state machine IAM role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "StepFunctionTrustPolicy"
        Principal = {
          Service = "states.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}
######################################## State Machine IAM Policy ##################################
resource "aws_iam_policy" "sf-iam-policy" {
  name        = local.sf_iam_policy_name
  path        = "/"
  description = "Daylily Step Function execution policy"


  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = data.aws_iam_policy_document.sf-iam-policy-document.json
}
######################################## State machine IAM Role / Policy attachment ################
resource "aws_iam_role_policy_attachment" "sf-iam-role-policy-attachment" {
  depends_on = [aws_iam_role.sf-iam-role, aws_iam_policy.sf-iam-policy]

  role       = aws_iam_role.sf-iam-role.name
  policy_arn = aws_iam_policy.sf-iam-policy.arn
}
