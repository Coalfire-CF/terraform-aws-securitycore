output "tstate_bucket_name" {
  value       = module.s3-tstate.id
  description = "The name of the terraform state bucket"
}

output "s3_key_iam" {
  value       = data.aws_iam_policy_document.s3_key.json
  description = "The name of the terraform state bucket"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.dynamodb_.name
}