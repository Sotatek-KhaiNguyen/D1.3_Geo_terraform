resource "aws_s3_bucket" "s3_static_page" {
    bucket = "${var.common.env}-${var.common.project}-storage"
}

# resource "aws_s3_bucket_website_configuration" "s3_web_config_storage" {
#     bucket = aws_s3_bucket.s3_static_page.bucket
#     index_document {
#         suffix = "index.html"
#     }

#     error_document {
#         key = "error.html"
#     }
# }

# resource "aws_s3_bucket_policy" "policy_static_page" {
#   bucket = aws_s3_bucket.s3_static_page.id

#   policy = jsonencode({
#     # Version = ""
#     # Id      = ""
#     Statement = [
#       {
#         Sid       = "AllowPublic"
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = "s3:GetObject"
#         Resource  = "${aws_s3_bucket.s3_static_page.arn}/**"
#       }
#     ]
#   })
# }

data "aws_iam_policy_document" "policy_doc" {
  # type = "CanonicalUser"
  # identifiers = ["FeCloudFrontOriginAccessIdentity.S3CanonicalUserId"]
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cf_oai.iam_arn]
    }
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_static_page.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.s3_static_page.id
  policy = data.aws_iam_policy_document.policy_doc.json
}

resource "aws_cloudfront_origin_access_identity" "cf_oai" {
  comment = "${var.common.env}-${var.common.project}-${var.cf_static_page_name}"
}

resource "aws_cloudfront_distribution" "cf_distribution" {
    origin {
        origin_id = "${var.common.env}-${var.common.project}-${var.cf_static_page_name}"
        domain_name = aws_s3_bucket.s3_static_page.bucket_regional_domain_name
        s3_origin_config {
          origin_access_identity = aws_cloudfront_origin_access_identity.cf_oai.cloudfront_access_identity_path
        }
    }

    restrictions {
      geo_restriction {
        restriction_type = "none"
      }
    }

    enabled = true
    default_cache_behavior {
      allowed_methods  = ["GET", "HEAD", "OPTIONS"]
      cached_methods   = ["GET", "HEAD", "OPTIONS"]
      target_origin_id = "${var.common.env}-${var.common.project}-${var.cf_static_page_name}"
      compress = true
      forwarded_values {
        query_string = false
        cookies {
          forward = "none"
        }
      }
      viewer_protocol_policy = "redirect-to-https"
      min_ttl = 60
      default_ttl = 3600
      max_ttl = 86400
    }
    viewer_certificate {
      acm_certificate_arn = var.cf_cert_arn
      ssl_support_method = "sni-only"
    }
    custom_error_response {
      error_caching_min_ttl = "10"
      error_code = "403"
      response_code = "200"
      response_page_path = "/index.html"
    }
    depends_on = [aws_s3_bucket.s3_static_page]
}

output "cf_distribution_domain_name" {
  value = aws_cloudfront_distribution.cf_distribution.domain_name
}

output "cf_distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.cf_distribution.hosted_zone_id
}

output "cf_distribution_id" {
  value = aws_cloudfront_distribution.cf_distribution.id
}