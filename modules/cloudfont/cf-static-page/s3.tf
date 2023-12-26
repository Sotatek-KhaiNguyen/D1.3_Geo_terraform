resource "aws_s3_bucket" "s3_static_page" {
    bucket = "${var.common.env}-${var.common.project}-storage"
}

resource "aws_s3_bucket_website_configuration" "s3_web_config_storage" {
    bucket = aws_s3_bucket.s3_cache.bucket
    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}

resource "aws_s3_bucket_policy" "policy_static_page" {
  bucket = aws_s3_bucket.policy_static_page.id

  policy = jsonencode({
    Version = ""
    Id      = ""
    Statement = [
      {
        Sid       = "AllowPublic"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.policy_static_page.arn}/**"
      }
    ]
  })
}