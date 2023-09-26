module "s3-tstate" {
  source = "github.com/Coalfire-CF/ACE-AWS-S3"

  name = "${var.resource_prefix}-${var.aws_region}-tf-state"
  kms_master_key_id = var.s3_kms_key_id
  attach_public_policy = false
  block_public_acls = true
  ignore_public_acls = true
  restrict_public_buckets = true
}