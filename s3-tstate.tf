module "s3-tstate" {
  source = "github.com/Coalfire-CF/terraform-aws-s3?ref=v1.0.1"

  name                    = "${var.resource_prefix}-${var.aws_region}-tf-state"
  kms_master_key_id       = var.s3_kms_key_arn
  attach_public_policy    = false
  block_public_acls       = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  bucket_policy           = length([for account in var.application_account_numbers : account if account != ""]) > 0
  aws_iam_policy_document = data.aws_iam_policy_document.tfstate_bucket_policy.json

  lifecycle_configuration_rules = [
    {
      id      = "default"
      enabled = true

      enable_glacier_transition            = false
      enable_current_object_expiration     = false
      enable_noncurrent_version_expiration = false

      abort_incomplete_multipart_upload_days = 1
    }
  ]
}
