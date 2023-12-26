resource "aws_cloudfront_origin_access_identity" "cf_oai" {
  comment = "${var.common.env}-${var.common.project}-${var.name}"
}

resource "aws_cloudfront_distribution" "cf_distribution" {
    origin {
        origin_id = "${var.common.env}-${var.common.project}-${var.name}"
        domain_name = "${var.aws_s3_bucket}-${var.s3_static_page}.bucket_regional_domain_name"
        s3_origin_config {
          origin_access_identity = aws_cloudfront_origin_access_identity.cf_oai.cloudfront_access_identity_path
        }
    }

    restrictions {
      geo_restriction {
        restriction_type = "none"
      }
    }

    default_cache_behavior {
      allowed_methods  = ["GET", "HEAD", "OPTIONS"]
      cached_methods   = ["GET", "HEAD", "OPTIONS"]
      target_origin_id = "${var.common.env}-${var.common.project}-${var.name}"
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