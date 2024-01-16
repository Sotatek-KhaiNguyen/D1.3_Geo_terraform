resource "aws_s3_bucket" "s3" {
  bucket = "${var.s3_name}-logs"
}

resource "aws_s3_bucket_policy" "allow_access_resource" {
  bucket = aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.allow_access_resource.json
}

data "aws_iam_policy_document" "allow_access_resource" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.s3_name}-logs"]
    actions   = ["s3:GetBucketAcl"]

    principals {
      type        = "Service"
      identifiers = ["logs.us-east-1.amazonaws.com"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.s3_name}-logs/*"]
    actions   = ["s3:PutObject"]

    principals {
      type        = "Service"
      identifiers = ["logs.us-east-1.amazonaws.com"]
    }
  }
}