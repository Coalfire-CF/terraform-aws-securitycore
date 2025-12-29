module "s3-tstate" {
  source = "git::https://github.com/Coalfire-CF/terraform-aws-s3?ref=v1.0.4"

  name                    = "${var.resource_prefix}-${var.aws_region}-tf-state"
  kms_master_key_id       = var.s3_kms_key_arn
  attach_public_policy    = false
  block_public_acls       = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  bucket_policy           = length([for account in var.application_account_numbers : account if account != ""]) > 0
  aws_iam_policy_document = data.aws_iam_policy_document.tfstate_bucket_policy.json

  tags = {
    backup_policy = var.backup_policy_name
  } 
}
