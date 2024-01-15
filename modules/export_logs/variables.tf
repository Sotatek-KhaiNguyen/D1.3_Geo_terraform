variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
}


####RDS##########
# variable "dev_rds_cloudwatch_logs" {}
# variable "dev_rds_s3_logs" {}

####REDIS#######
# variable "dev_redis_slowly_logs" {}
# variable "dev_redis_engine_logs" {}
# variable "dev_redis_engine_s3_logs" {}
# variable "dev_redis_slowly_s3_logs" {}