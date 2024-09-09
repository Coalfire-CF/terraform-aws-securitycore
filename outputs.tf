output "tstate_bucket_name" {
  value       = module.s3-tstate.id
  description = "The name of the terraform state bucket"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.dynamodb_.name
}