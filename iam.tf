

data "aws_iam_policy_document" "s3_key" {

  dynamic "statement" {
    for_each = var.application_account_numbers
    content {
      effect = "Allow"
      actions = [
        "kms:*"]
      resources = [
        "*"]
      principals {
        identifiers = [
          "arn:${data.aws_partition.current}:iam::${statement.value}:root"]
        type = "AWS"
      }
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:*"]
    resources = [
      "*"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current}:iam::${var.account_number}:root"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
      "*"]

    principals {
      type = "Service"
      identifiers = [
        "delivery.logs.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
      "*"]

    principals {
      type = "Service"
      identifiers = [
        "logs.${var.aws_region}.amazonaws.com"]
    }
  }

  statement {
    sid = "Enable CloudTrail Encrypt Permissions"
    effect = "Allow"
    actions = [
      "kms:GenerateDataKey*"]
    resources = [
      "*"]
    condition {
      test = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:${data.aws_partition.current}:cloudtrail:*:${var.account_number}:trail/*"]
    }
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"]
    }
  }

  dynamic "statement" {
    for_each = var.application_account_numbers
    content {
      effect = "Allow"
      actions = [
        "kms:GenerateDataKey*"]
      resources = [
        "*"]
      condition {
        test = "StringLike"
        variable = "kms:EncryptionContext:aws:cloudtrail:arn"
        values = [
          "arn:${data.aws_partition.current}:cloudtrail:*:${statement.value}:trail/*"]
      }
      principals {
        type = "Service"
        identifiers = [
          "cloudtrail.amazonaws.com"]
      }
    }
  }
}



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