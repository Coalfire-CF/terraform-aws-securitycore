# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb_" {
  name           = "${var.resource_prefix}-${var.aws_region}-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
  depends_on = [module.s3-tstate]
}