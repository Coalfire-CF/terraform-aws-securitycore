data "aws_iam_policy_document" "tfstate_bucket_policy" {

  dynamic "statement" {
    for_each = var.application_account_numbers
    content {
      actions = ["s3:PutObject", "s3:GetObject", "s3:ListBucket"]
      effect  = "Allow"
      principals {
        identifiers = [statement.value]
        type        = "AWS"
      }
      resources = ["${module.s3-tstate.arn}/*", module.s3-tstate.arn]
    }
  }
}
