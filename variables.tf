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
  type        = list(string)

}

variable "account_number" {
  description = "account number for the mgmt account"
  type        = string
}

variable "create_dynamo_kms_key" {
  description = "create KMS key for dynamodb"
  type        = bool
  default     = true
}

variable "create_s3_kms_key" {
  description = "create KMS key for S3"
  type        = bool
  default     = true
}


