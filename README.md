# Project Daylily: A Setp Function Demo - Transfer Data Records (Lambda, DynamoDB, Amazon SQS)

This is a simple demo of an AWS Step function using Lambda, DynamoDB, SQS Queue to show looping within a workflow.

## Description

This is a demo of a step function to loop through a list of items. In the first state a Lambda function inserts some quotes (with is passed as an input) to the DynamoDB table and returns a list of patrtition keys. The state machine then loops through the list and in each iteration fetches the quote from the DynamoDB table and pushes it to a SQS Queue.

The entire stack is created using HashiCorp Terraform. Only for higher environment (test/prod) the SNS Topic will be encrypted using Customer Managed KMS Key.

![Project Daylily - Design Diagram](https://subhamay-projects-repository-us-east-1.s3.amazonaws.com/0086-daylily/daylily-architecture-diagram.png)

![Project Daylily - Services Used](https://subhamay-projects-repository-us-east-1.s3.amazonaws.com/0086-daylily/daylily-services-used-tf.png?)

![Project Daylily - Workflow](https://subhamay-projects-repository-us-east-1.s3.amazonaws.com/0086-daylily/daylily-step-function.png?)


### Installing

* Clone the repository.
* Create a S3 bucket to store the terraform state file.
* Create the folder - 0069-daylily/
* Create a KMS Key for higher environment (test/prod) in the region where you want to deply the stack.
* Create the terraform.tfvars file with the appropriate variable values, a sample of it provided below:
    ```
        ## ---------------------------------------------------------------------------------------------------------------------
        ## Variable Values - Project Daylily
        ## Modification History:
        ##   - 1.0.0    Jun 3,2023   -- Initial Version
        ## ---------------------------------------------------------------------------------------------------------------------

        ######################################## Project Name ##############################################
        project_name = "daylily"
        ######################################## Environment Name ##########################################
        environment_name = "devl"
        ######################################## KMS Key ###################################################
        kms_key_alias = "alias/SB-KMS"
        kms_key_arn = {
        "us-east-1" = "arn:aws:kms:us-east-1:807724355529:key/e4c733c5-9fbe-4a90-bda1-6f0362bc9xxx"
        "us-east-2" = "arn:aws:kms:us-east-2:807724355529:key/dfc9fe4a-7021-4eb8-a8e9-520a2f91fyyy"
        "us-west-2" = "arn:aws:kms:us-west-2:807724355529:key/2e99fc66-0257-4f12-841e-38dcddb71zzz"
        }
        ######################################## SNS Topic #################################################
        sns_topic_base_name    = "sns-topic"
        sns_topic_display_name = "Daylily SNS Topic used in the step function using SNS and Wait state."
        ######################################## SNS Topic Subscription ####################################
        sns_subscription_email = ["subhamay.aws@mailinator.com", "subhamay@mailinator.com"]
        ######################################## Step Function IAM Role ####################################
        sf_iam_role_name   = "step-function-role"
        sf_iam_policy_name = "step-function-policy"
    ```
* Modify the 01-provider.tf and change the S3 bucket to store the state region where you want to deploy the stack
* Run the following terraform commands from the projec directory:
    * terraform init
    * terraform validate
    * terraform plan
    * terraform apply -auto-approve
* To delete the stack run the following command:
    * terraform destroy -auto-approve

### Executing program

* Go to the Step Function Console and use the sample input and start the execution
* Step-by-step bullets
```

```

## Help

Post message in my blog (https://blog.subhamay.com)

## Authors

Contributors names and contact info

Subhamay Bhattacharyya  - [subhamay.aws@gmail.com](https://blog.subhamay.com)

## Reference
https://docs.aws.amazon.com/step-functions/latest/dg/sample-project-transfer-data-sqs.html

## Version History

* 0.1
    * Initial Release

## License

None

## Acknowledgments
AWS 

