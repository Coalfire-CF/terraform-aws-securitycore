<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

## ACE-AWS-SecurityCore Module

## Dependencies

- IAM AWS Accounts

## Resource List

- S3 for Terraform State
- DynamoDB for Terraform State
- KMS keys for DynamoDB and S3
- IAM roles for above resources

## Code Updates


## Deployment Steps

This module can be called as outlined below.

- Change directories to the `reponame` directory.
- From the `terraform/aws/security-core` directory run `terraform init`.
- Run `terraform plan` to review the resources being created.
- If everything looks correct in the plan output, run `terraform apply`.

## Usage

Include example for how to call the module below with generic variables

```hcl
provider "aws" {
  features {}
}

module "securitycore" {
  source                    = "github.com/Coalfire-CF/ACE-AWS-SecurityCore?ref=draft"
  aws_region = "us-gov-west-1"
  resource_prefix = var.resource_prefix
  application_account_numbers = var.app_account_ids
  account_number = data.aws_caller_identiy.mgmt_account.id
}
```

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
| <a name="module_dynamo_kms_key"></a> [dynamo\_kms\_key](#module\_dynamo\_kms\_key) | github.com/Coalfire-CF/ACE-AWS-KMS | draftv0.0.2 |
| <a name="module_s3-tstate"></a> [s3-tstate](#module\_s3-tstate) | github.com/Coalfire-CF/ACE-AWS-S3 | draftv0.0.2 |
| <a name="module_s3_kms_key"></a> [s3\_kms\_key](#module\_s3\_kms\_key) | github.com/Coalfire-CF/ACE-AWS-KMS | draftv0.0.2 |

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
| <a name="input_application_account_numbers"></a> [application\_account\_numbers](#input\_application\_account\_numbers) | Account IDs for application accounts to be used in IAM | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create things in | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix for the s3 bucket names | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamo_key_arn"></a> [dynamo\_key\_arn](#output\_dynamo\_key\_arn) | The arn of the dynamo kms key |
| <a name="output_dynamo_key_id"></a> [dynamo\_key\_id](#output\_dynamo\_key\_id) | The id of the dynamo key |
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
