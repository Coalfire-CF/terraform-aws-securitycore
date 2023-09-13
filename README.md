<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

## ACE-AWS-SecurityCore

## Dependencies

- IAM AWS Accounts

## Resource List

- S3 for Terraform State
- DynamoDB for Terraform State
- KMS keys for DynamoDB and S3
- IAM roles for above resrouces.

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

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)


## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)


## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
