iam_credentials = {
  key = "AKIARQZT7GZLRSQRCIWU"
  secret = "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"
}

pipeline = {
  role_codepipeline = "arn:aws:iam::115228050885:role/service-role/AWSCodePipelineServiceRole-us-east-1-test"
  pipeline_bucket = "aaaaa123452131"
}

network = {
  vpc_id_private = "vpc-0f6f1f927ab619182"
  subnet_ids = ["subnet-0c0000e20a986bf14", "subnet-0338bced2e9f2a40b	"]
  sg_container = "default"
}

cf_cert_arn = "arn:aws:acm:us-east-1:104798828119:certificate/52eb723b-c81a-4cb5-9baf-2418c84599bb"
cdn_domain = "cdn.sotatek.com"


cf_static_page_name = "static-page"