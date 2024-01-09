resource "aws_route53_record" "record" {
  zone_id = var.hosted_zone_public_id
  name = var.record_name
  type = "CNAME"
  records = [var.domain_name_cf]
}
