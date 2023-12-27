#=================common=======================
project = "geotechnologies-ugc-app"
env = "dev"
region = "ap-southeast-1"
account_id = "115228050885"

#=================ECR=========================
image_tag_mutability = "MUTABLE"



#=======================EC2=================================
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1HNnCuTxWgUhCPxr5UKm90BH4i4XymHNfNh3eZXSOGkbW+oDvZstBdczUWgcHAExi2nA2NV9Lkgb01h02DUkgL2hIlbMRNd02Y+MBjYUtvLvdIz3hXulOkqxFsAGF/yk2aKOVrd254T7C1xyHxi1XGdVHb1Bc61qagT32aFArAorbzBC5/9XTzhGkMr0pOp0qtxU+y/e+YO/gAAxYTvCPaFJKiFLI3+yCX0C4dA2kny3sGva2/ky7K9nvIS3EeZu8NkY3m2Cq7196EqNPmWvkhLdIktNxplZZOxmItFBkomWsqY6l1Cxw2Bv2n2KfWued7f9ms8MN3/OyGCapnnw7tcgnwULFd+45tMUqh4RaIiCFw9oFg6x9RHCXMzFnIQl74Zc4uS8I4lTcoctsf2BAhylD4wXB94OANBuhJVNLL2Bj9jVm8Gjtjtv4+IfqnI7v8jyP1lBR0SrPvzkDO53WJT6h8QIH1OA++w0upR14D/DW6jKdqpsoWdMr//U0Gmc= tanvn32@tanvn32-MS-7C67"
vpc_id = "vpc-0f6f1f927ab619182"
subnet_id = "subnet-00141605612999d66"
security_group = "default"


#=======================ci/cd=====================================
pipeline = {
  role_codepipeline = "arn:aws:iam::115228050885:role/service-role/AWSCodePipelineServiceRole-us-east-1-test"
  pipeline_bucket = "aaaaa123452131"
}
git_url = "git@github.com:Sotatek-KhaiNguyen/terraform_D1.3_Geotechnologies.git"
branch = "main"
repo = "terraform_D1.3_Geotechnologies"
name = "test"
role_codebuild = "arn:aws:iam::115228050885:role/test"


#=======================redis cache=====================================
network = {
  vpc_id_private = "vpc-0f6f1f927ab619182"
  subnet_ids = ["subnet-0c0000e20a986bf14", "subnet-0338bced2e9f2a40b	"]
  sg_container = "default"
}
redis_engine_version = "redis"
num_cache_nodes = "1"
node_type = "cache.t4g.medium"
port = "6379"


#=======================rds=====================================
rds_port = "3306"
rds_family = "mysql8.0"
rds_engine = "mysql"
rds_engine_version = "8.0"
rds_name = "api"
rds_class = "db.t3.xlarge"
rds_strorage = "100"


#========================route53cdn=================
hosted_zone_public_id = "test"
domain_name = "test.sotatek.com"
cf_s3_domain_name = "s3.sotatek.com"
cf_s3_hosted_zone_id = "zone_id_test"


#========================route53lb=================
lb_domain_name = "lb.sotatek.com"
lb_hosted_zone_id = "zone_id_test"


#=======================cf-cdn=========================
cf_cert_arn = "arn:aws:acm:us-east-1:104798828119:certificate/52eb723b-c81a-4cb5-9baf-2418c84599bb"
cdn_domain = "cdn.sotatek.com"


#=======================cf-cdn=========================
cf_static_page_name = "static-page"