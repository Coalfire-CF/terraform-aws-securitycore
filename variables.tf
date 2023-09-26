variable "aws_region" {
  description = "The AWS region to create things in"
  type        = string
}

variable "resource_prefix" {
  description = "The prefix for the s3 bucket names"
  type        = string
}

variable "application_account_numbers" {
  description = "Account IDs for application accounts to be used in IAM"
  type        = string
}

variable "account_number" {
  description = "account number for the mgmt account"
  type = string
}

variable "s3_kms_key_id" {
  description = "the aws kms key id for S3 buckets"
  type = string
}


