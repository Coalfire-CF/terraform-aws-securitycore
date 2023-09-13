output "s3_key_arn" {
  value = module.s3_kms_key.kms_key_arn
  description = "The arn of the s3 kms key"
}

output "s3_key_id" {
  value = module.s3_kms_key.kms_key_id
  description = "The id of the s3 key"
}

output "dynamo_key_arn" {
  value = module.dynamo_kms_key.kms_key_arn
  description = "The arn of the dynamo kms key"
}

output "dynamo_key_id" {
  value = module.dynamo_kms_key.kms_key_id
  description = "The id of the dynamo key"
}

output "tstate_bucket_name" {
  value = module.s3-tstate.id
  description = "The name of the terraform state bucket"
}