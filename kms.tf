module "s3_kms_key" {
  source = "github.com/Coalfire-CF/terraform-aws-kms?ref=v0.0.6"

  key_policy            = data.aws_iam_policy_document.s3_key.json
  kms_key_resource_type = "s3"
  resource_prefix       = var.resource_prefix
}

module "dynamo_kms_key" {
  source = "github.com/Coalfire-CF/terraform-aws-kms?ref=v0.0.6"

  kms_key_resource_type = "dynamodb"
  resource_prefix       = var.resource_prefix
}


