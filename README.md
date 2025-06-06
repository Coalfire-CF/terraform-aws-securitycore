![Coalfire](coalfire_logo.png)

# terraform-aws-securitycore

## Description

This module creates the necessary resources to store your Terraform code remotely in AWS and is tied to the 'terraform-aws-account-setup' module; it should not be deployed separately.

FedRAMP Compliance: Moderate, High

## Dependencies

- terraform-aws-account-setup (https://github.com/Coalfire-CF/terraform-aws-account-setup)

## Resource List

- S3 for Terraform State
- IAM Policy document

## S3 State File Locking

To utilize S3-native locking instead of DynamoDB you will remove the dynamodb_table line from your 'remote-data.tf' file and replace it with 'use_lockfile=true'. The lock file will now appear in the designated bucket assigned in the 'remote-data.tf' file. The name of the lock file will be the same as the state file with a .tflock extension added to the end. This can be tested by running a terraform plan and refreshing the tfstate S3 bucket; you should see the lock file appear and then disappear when the Terraform code is done running. 

```hcl
terraform {
  backend "s3" {
    bucket         = "<environment-name>>-us-gov-west-1-tf-state"
    region         = "us-gov-west-1"
    key            = "<environment-name>/us-gov-west-1/account-setup.tfstate"
    encrypt        = true
    use_lockfile   = true
  }
}
```

## Usage

```hcl
module "security-core" {
   source = "github.com/Coalfire-CF/terraform-aws-securitycore?ref=vX.X.X"

   application_account_numbers = var.application_account_numbers
   aws_region                  = var.aws_region
   resource_prefix             = var.resource_prefix

   # KMS Keys
   s3_kms_key_arn              = var.s3_kms_key_arn
}
```

## Environment Setup

```hcl
IAM user authentication:

- Download and install the AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Log into the AWS Console and create AWS CLI Credentials (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
- Configure the named profile used for the project, such as 'aws configure --profile example-mgmt'

SSO-based authentication (via IAM Identity Center SSO):

- Login to the AWS IAM Identity Center console, select the permission set for MGMT, and select the 'Access Keys' link.
- Choose the 'IAM Identity Center credentials' method to get the SSO Start URL and SSO Region values.
- Run the setup command 'aws configure sso --profile example-mgmt' and follow the prompts.
- Verify you can run AWS commands successfully, for example 'aws s3 ls --profile example-mgmt'.
- Run 'export AWS_PROFILE=example-mgmt' in your terminal to use the specific profile and avoid having to use '--profile' option.
```

## Deployment

1. Navigate to the Terraform project and create a parent directory in the upper level code, for example:

    ```hcl
    ../{CLOUD}/terraform/{REGION}/management-account/example
    ```

   If multi-account management plane:

    ```hcl
    ../{CLOUD}/terraform/{REGION}/{ACCOUNT_TYPE}-mgmt-account/example
    ```

2. Create a properly defined main.tf file via the template found under 'Usage' while adjusting tfvars as needed. Note that many provided variables are outputs from other modules. Example parent directory (modify this tree to reflect what the parent module should look like):

   ```hcl
     ├── Example/
     │   ├── example.auto.tfvars   
     │   ├── main.tf
     │   ├── outputs.tf
     │   ├── providers.tf
     │   ├── required-providers.tf
     │   ├── remote-data.tf
     │   ├── variables.tf 
     │   ├── ...
     ```

3. Configure Terraform local backend and stage remote backend. For the first run, the entire contents of the 'remote-data.tf' file must be commented out with terraform local added to facilitate local state setup, like below:
   ```hcl
   //terraform {
   //  backend "s3" {
   //    bucket         = "{resource_prefix}-{region}-tf-state"
   //    region         = "{region}"
   //    key            = "{resource_prefix}-{region}-security-core.tfstate"
   //    encrypt        = true
   //    use_lockfile   = true
   //  }
   //}
   terraform {
   backend "local"{}
   }
   ```
   
4. Initialize the Terraform working directory:
   ```hcl
   terraform init
   ```
   Create an execution plan and verify the resources being created:
   ```hcl
   terraform plan
   ```
   Apply the configuration:
   ```hcl
   terraform apply
   ```

5. After the deployment has succeeded, uncomment the contents of 'remote-state.tf' and remove the terraform local code block.

6. Run 'terraform init -migrate-state' and follow the prompts to migrate the local state file to the appropriate S3 bucket in the management plane.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamo_kms_key"></a> [dynamo\_kms\_key](#module\_dynamo\_kms\_key) | github.com/Coalfire-CF/terraform-aws-kms | n/a |
| <a name="module_s3-tstate"></a> [s3-tstate](#module\_s3-tstate) | github.com/Coalfire-CF/terraform-aws-s3 | n/a |
| <a name="module_s3_kms_key"></a> [s3\_kms\_key](#module\_s3\_kms\_key) | github.com/Coalfire-CF/terraform-aws-kms | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.dynamodb_](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy_document.s3_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.tfstate_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | account number for the mgmt account | `string` | n/a | yes |
| <a name="input_application_account_numbers"></a> [application\_account\_numbers](#input\_application\_account\_numbers) | Account IDs for application accounts to be used in IAM | `list(string)` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create things in | `string` | n/a | yes |
| <a name="input_create_dynamo_kms_key"></a> [create\_dynamo\_kms\_key](#input\_create\_dynamo\_kms\_key) | create KMS key for dynamodb | `bool` | `true` | no |
| <a name="input_create_s3_kms_key"></a> [create\_s3\_kms\_key](#input\_create\_s3\_kms\_key) | create KMS key for S3 | `bool` | `true` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix for the s3 bucket names | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamo_key_arn"></a> [dynamo\_key\_arn](#output\_dynamo\_key\_arn) | The arn of the dynamo kms key |
| <a name="output_dynamo_key_id"></a> [dynamo\_key\_id](#output\_dynamo\_key\_id) | The id of the dynamo key |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | n/a |
| <a name="output_s3_key_arn"></a> [s3\_key\_arn](#output\_s3\_key\_arn) | The arn of the s3 kms key |
| <a name="output_s3_key_iam"></a> [s3\_key\_iam](#output\_s3\_key\_iam) | The name of the terraform state bucket |
| <a name="output_s3_key_id"></a> [s3\_key\_id](#output\_s3\_key\_id) | The id of the s3 key |
| <a name="output_tstate_bucket_name"></a> [tstate\_bucket\_name](#output\_tstate\_bucket\_name) | The name of the terraform state bucket |
<!-- END_TF_DOCS -->

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)


## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)


## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3-tstate"></a> [s3-tstate](#module\_s3-tstate) | github.com/Coalfire-CF/terraform-aws-s3 | v1.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.dynamodb_](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy_document.tfstate_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_account_numbers"></a> [application\_account\_numbers](#input\_application\_account\_numbers) | Account IDs for application accounts to be used in IAM | `list(string)` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create things in | `string` | n/a | yes |
| <a name="input_dynamo_kms_key_arn"></a> [dynamo\_kms\_key\_arn](#input\_dynamo\_kms\_key\_arn) | ARN for the CMK KMS key for DynamoDB | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix for the s3 bucket names | `string` | n/a | yes |
| <a name="input_s3_kms_key_arn"></a> [s3\_kms\_key\_arn](#input\_s3\_kms\_key\_arn) | ARN for the CMK KMS key for S3 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamo_key_arn"></a> [dynamo\_key\_arn](#output\_dynamo\_key\_arn) | The arn of the dynamo kms key |
| <a name="output_dynamo_key_id"></a> [dynamo\_key\_id](#output\_dynamo\_key\_id) | The id of the dynamo key |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | n/a |
| <a name="output_s3_key_arn"></a> [s3\_key\_arn](#output\_s3\_key\_arn) | The arn of the s3 kms key |
| <a name="output_s3_key_iam"></a> [s3\_key\_iam](#output\_s3\_key\_iam) | The name of the terraform state bucket |
| <a name="output_s3_key_id"></a> [s3\_key\_id](#output\_s3\_key\_id) | The id of the s3 key |
| <a name="output_tstate_bucket_name"></a> [tstate\_bucket\_name](#output\_tstate\_bucket\_name) | The name of the terraform state bucket |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
