## ---------------------------------------------------------------------------------------------------------------------
## Data Definition - Step Function Module
## Modification History:
##   - 1.0.0    Jun 15,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# AWS Region and Caller Identity
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}