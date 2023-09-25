module "s3_kms_key" {
  source = "github.com/Coalfire-CF/ACE-AWS-KMS?ref=draftv0.0.2"

  key_policy            = data.aws_iam_policy_document.s3_key.json
  kms_key_resource_type = "s3"
  resource_prefix       = var.resource_prefix
}

module "dynamo_kms_key" {
  source = "github.com/Coalfire-CF/ACE-AWS-KMS?ref=draftv0.0.2"

  kms_key_resource_type = "dyanmo"
  resource_prefix       = var.resource_prefix
}


