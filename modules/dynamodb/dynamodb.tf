resource "aws_dynamodb_table" "table" {
  name             = "${var.common.env}-${var.common.project}-${var.table_name}"
  hash_key         = var.hash_key
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = var.hash_key
    type = "S"
  }
}