resource "aws_route53_record" "record" {
  zone_id = var.hosted_zone_public_id
  name = var.domain_name
  type = "A"
  alias {
    name = var.lb_domain_name
    zone_id = var.lb_hosted_zone_id
    evaluate_target_health = false
  }
}
