## ---------------------------------------------------------------------------------------------------------------------
## Data Definition - IAM Execution Role Module
## Modification History:
##   - 1.0.0    Jun 15,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# AWS Region and Caller Identity
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# Lambda IAM Policy Document
data "aws_iam_policy_document" "sf-iam-policy-document" {

  dynamic "statement" {
    for_each = var.environment_name == "prod" || var.environment_name == "test" ? [true] : []
    content {
      sid = "AllowKMSEncryptionDecryption"
      actions = [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:GenerateDataKey",
        "kms:GenerateDataKeyPair"
      ]
      resources = [var.kms_key_arn[data.aws_region.current.name]]
    }
  }

  statement {
    sid = "AllowSNSPublish"

    actions = [
      "sns:Publish"
    ]

    resources = [
      "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${local.sns_topic_name}"
    ]
  }
}
