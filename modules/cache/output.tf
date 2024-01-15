
output "dev_redis_slowly_logs" {
  value = aws_cloudwatch_log_group.log_group_slowly.name
}

output "dev_redis_engine_logs" {
  value = aws_cloudwatch_log_group.log_group_engine.name
}

output "dev_redis_engine_s3_logs" {
  value = aws_s3_bucket.engine_s3.bucket
}

output "dev_redis_slowly_s3_logs" {
  value = aws_s3_bucket.slowly_s3.bucket
}