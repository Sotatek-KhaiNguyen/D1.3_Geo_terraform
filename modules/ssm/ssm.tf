resource "aws_ssm_parameter" "ssm" {
  for_each = var.source_services
  name = "/${var.common.env}/${var.common.project}/${each.key}/env"
  type        = "SecureString"
  value       = "env"
  tags = {
    environment = "${var.common.env}"
  }
  lifecycle {
    ignore_changes = [value]
  }
}