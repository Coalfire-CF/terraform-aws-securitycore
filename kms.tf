module "s3_kms_key" {
  count = var.create_s3_kms_key ? 1 : 0
  source = "github.com/Coalfire-CF/terraform-aws-kms"

  key_policy            = data.aws_iam_policy_document.s3_key.json
  kms_key_resource_type = "s3"
  resource_prefix       = var.resource_prefix
}

module "dynamo_kms_key" {
  count = var.create_dynamo_kms_key ? 1 : 0

  source = "github.com/Coalfire-CF/terraform-aws-kms"

  kms_key_resource_type = "dyanmo"
  resource_prefix       = var.resource_prefix
}


