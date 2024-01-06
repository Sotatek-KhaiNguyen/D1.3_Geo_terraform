#=================common=======================
project = "geotechnologies-ugc-app"
env = "dev"
region = "us-east-1"
account_id = "115228050885"

#=================ECR=========================
image_tag_mutability = "MUTABLE"



#=======================EC2=================================
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3HN1YSS1zIQ01goxSEwpgfq5rhqJy0RKKhwrL8aD/fK4z9XpXOyQFkiyoSfbdAxD8LRZJNoZtRINRjN1G1pQ9xSzWYGrM0SjtBW/sQw2v40Pdn8Tda4dHf3EVOWISUboRjpOR9eZuhmHKqgjO8u+TRUHOUCuFxjEypwu0YTI7rg8nro9GrOqmR/Ayyw6v3hYyltbS+gij7GWXVwb89HznaGfM3jU6xU7SVxlcxVpCpjB9+x5sXILBu3scCcUvMM3NPzMSmLwnfQtETE8A7kRuWW+MrGBUFH7rXN1zoYLqCUIUEk+DSMxlZ8gc6hBlViDmUKxfdz8HkTiGHVE+rrJYz7M32gaG/Ukk9BunEIU/oYE1XxIjhXOszEm9MP3uWk1fywcY8y4QE328vAOLkUJVte5CyC6aUOTvOV9uImsbCdwB359QSK7c+pSLTc1eSyQSZasbNLpJrTFVyE4eWgaA07lGTlPKoxMaPF7idw2MWuzvGUMpC7i3+psLvMtksqU="
#vpc_id = "vpc-0f6f1f927ab619182"
#subnet_id = "subnet-00141605612999d66"
#security_group = "default"


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
# network = {
#   vpc_id_private = "vpc-0f6f1f927ab619182"
#   subnet_ids = ["subnet-0c0000e20a986bf14", "subnet-0338bced2e9f2a40b	"]
#   sg_container = "default"
# }
redis_engine_version = "redis"
num_cache_nodes = "1"
node_type = "cache.t4g.medium"
ports = ["6379", "22"]


#=======================rds=====================================
rds_port = "3306"
rds_family = "mysql8.0"
rds_engine = "mysql"
rds_engine_version = "8.0.35"
rds_name = "api"
rds_class = "db.t3.micro"
rds_strorage = "10"


#========================route53cdn=================
hosted_zone_public_id = "test"
domain_name = "khai.devops.donnytran.com"
cf_s3_domain_name = "s3.sotatek.com"
cf_s3_hosted_zone_id = "zone_id_test"


#========================route53lb=================
lb_domain_name = "lb.sotatek.com"
lb_hosted_zone_id = "zone_id_test"


#=======================cf-cdn=========================
cf_cert_arn = "arn:aws:acm:us-east-1:115228050885:certificate/095bf072-a70e-4821-8e0a-46fbc88d5935"
cdn_domain = "cdn.sotatek.com"


#=======================cf-fe=========================
cf_static_page_name = "static"

#=======================ecs-base===============================
#vpc_id_private = "vpc-0f6f1f927ab619182"

#=======================ecs-scale===============================
# ecs_scale_name = "ugc-ecs"
# container_name = "ugc-container" 
# command = "pwd"
# container_port = "80"
# desired_count = "2"
# task_cpu = "512"
# task_ram = "2048"
# min_containers = "3"
# max_containers = "5"
# auto_scaling_target_value_cpu = "2"
# auto_scaling_target_value_ram = "4"
#sg_lb = "default"
#tg_arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/my-targets/73e2d6bc24d8a067"
# ecs = {
#   role_auto_scaling = ""
#   role_execution = ""
#   role_ecs_service = "" 
#   ecs_cluster_id = ""
#   ecs_cluster_name = ""
# }
ecs_service = [
  {
    service_name = "api"
    container_name = "ugc-container" 
    command = "pwd"
    container_port = "80"
    desired_count = "1"
    task_cpu = "512"
    task_ram = "2048"
    min_containers = "1"
    max_containers = "3"
    auto_scaling_target_value_cpu = "2"
    auto_scaling_target_value_ram = "4"
  }
]

#========================VPC=====================================
vpc_cidr = "172.16.0.0/16"
public_subnet_numbers = {
  "us-east-1a" = 1
  "us-east-1c" = 2
}
private_subnet_numbers = {
  "us-east-1a" = 4
  "us-east-1c" = 5
}

#=======================CICD====================================
codebuild_image = "BUILD_GENERAL1_SMALL"
codebuild_compute_type = "aws/codebuild/standard:5.0"
#OAuthToken = "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"
#codebuild_buildspec = "devops/buildspec.yml"
github_repos = [
  { 
    name = "testingnewpipeline", 
    branch="main", 
    organization="Sotatek-KhaiNguyen",
    buildspec_variables=[
      {
        key   = "REPOSITORY_URI"
        value = "115228050885.dkr.ecr.us-east-1.amazonaws.com/dev-geotechnologies-ugc-app-ugc-container"
      }
    ] 
  }
]

#=========================ACM for lb==================================
dns_cert_arn = "arn:aws:acm:us-east-1:115228050885:certificate/0c9c7e80-e373-4089-9087-857adaa5ab9e"

#==========================target group===============================
health_check_path = "/"
host_header = "khai.devops.donnytran.com"
priority = "100"