output "tstate_bucket_name" {
  value       = module.s3-tstate.id
  description = "The name of the terraform state bucket"
}