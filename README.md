![Coalfire](coalfire_logo.png)

# AWS Security Core Terraform Module

## Description

This module creates the necessary resources to store your Terraform code remotely in AWS.

FedRAMP Compliance: Moderate, High

## Dependencies

- IAM access to AWS Account(s)

## Resource List

- S3 for Terraform State
- KMS keys for S3
- IAM roles for above resources

## Deployment Steps

This module can be called as outlined below.

- Change directories to the `terraform-aws-securitycore` directory.
- From the `terraform-aws-security-core` directory run `terraform init`.
- Run `terraform plan` to review the resources being created.
- If everything looks correct in the plan output, run `terraform apply`.

## Lock State File

DynamoDB has been removed from security core in favor of S3-native state locking. To utilize S3-native locking, you will remove the dynamodb_table line from your tstate.tf file and/or your backends/tfvars and replace it with use_lockfile=true. This is how your tstate.tf file should look:

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

With S3-native state locking, the lock file will now appear in the designated bucket assigned in the tstate.tf file. The name of the lock file will be the same as the state file with a .tflock extension added to the end. This can be tested by running a terraform plan and refreshing the tfstate S3 bucket; you should see the lock file appear and then disappear when the Terraform code is done running. 

## Usage

Include example for how to call the module below with generic variables

```hcl
provider "aws" {
  features {}
}

module "security-core" {
  source = "github.com/Coalfire-CF/terraform-aws-securitycore?ref=vX.X.X"

  application_account_numbers = var.application_account_numbers
  aws_region                  = var.aws_region
  resource_prefix             = var.resource_prefix

  # KMS Keys
  s3_kms_key_arn     = module.s3_kms_key[0].kms_key_arn
}
```

<!-- BEGIN_TF_DOCS -->
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
| <a name="module_s3-tstate"></a> [s3-tstate](#module\_s3-tstate) | github.com/Coalfire-CF/terraform-aws-s3 | v1.0.4 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.tfstate_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_account_numbers"></a> [application\_account\_numbers](#input\_application\_account\_numbers) | Account IDs for application accounts to be used in IAM | `list(string)` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create things in | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix for the s3 bucket names | `string` | n/a | yes |
| <a name="input_s3_kms_key_arn"></a> [s3\_kms\_key\_arn](#input\_s3\_kms\_key\_arn) | ARN for the CMK KMS key for S3 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
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
| [aws_iam_policy_document.tfstate_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_account_numbers"></a> [application\_account\_numbers](#input\_application\_account\_numbers) | Account IDs for application accounts to be used in IAM | `list(string)` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create things in | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix for the s3 bucket names | `string` | n/a | yes |
| <a name="input_s3_kms_key_arn"></a> [s3\_kms\_key\_arn](#input\_s3\_kms\_key\_arn) | ARN for the CMK KMS key for S3 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_key_arn"></a> [s3\_key\_arn](#output\_s3\_key\_arn) | The arn of the s3 kms key |
| <a name="output_s3_key_iam"></a> [s3\_key\_iam](#output\_s3\_key\_iam) | The name of the terraform state bucket |
| <a name="output_s3_key_id"></a> [s3\_key\_id](#output\_s3\_key\_id) | The id of the s3 key |
| <a name="output_tstate_bucket_name"></a> [tstate\_bucket\_name](#output\_tstate\_bucket\_name) | The name of the terraform state bucket |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
