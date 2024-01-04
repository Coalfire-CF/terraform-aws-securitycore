module "s3-tstate" {
  source = "github.com/Coalfire-CF/terraform-aws-s3"

  name                    = "${var.resource_prefix}-${var.aws_region}-tf-state"
  kms_master_key_id       = module.s3_kms_key.kms_key_id
  attach_public_policy    = false
  block_public_acls       = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  aws_iam_policy_document = data.aws_iam_policy_document.tfstate_bucket_policy.json
}