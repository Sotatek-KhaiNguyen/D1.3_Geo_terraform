#=================common=======================
project = "ugc-geotech"
env = "dev"
region = "us-east-1"
account_id = "115228050885"

#=================ECR=========================
image_tag_mutability = "MUTABLE"


#=======================EC2=================================
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3HN1YSS1zIQ01goxSEwpgfq5rhqJy0RKKhwrL8aD/fK4z9XpXOyQFkiyoSfbdAxD8LRZJNoZtRINRjN1G1pQ9xSzWYGrM0SjtBW/sQw2v40Pdn8Tda4dHf3EVOWISUboRjpOR9eZuhmHKqgjO8u+TRUHOUCuFxjEypwu0YTI7rg8nro9GrOqmR/Ayyw6v3hYyltbS+gij7GWXVwb89HznaGfM3jU6xU7SVxlcxVpCpjB9+x5sXILBu3scCcUvMM3NPzMSmLwnfQtETE8A7kRuWW+MrGBUFH7rXN1zoYLqCUIUEk+DSMxlZ8gc6hBlViDmUKxfdz8HkTiGHVE+rrJYz7M32gaG/Ukk9BunEIU/oYE1XxIjhXOszEm9MP3uWk1fywcY8y4QE328vAOLkUJVte5CyC6aUOTvOV9uImsbCdwB359QSK7c+pSLTc1eSyQSZasbNLpJrTFVyE4eWgaA07lGTlPKoxMaPF7idw2MWuzvGUMpC7i3+psLvMtksqU="


#=======================redis cache=====================================
redis_engine_version = "redis"
num_cache_nodes = "1"
node_type = "cache.t4g.medium"
ports = ["6379"]


#=======================rds=====================================
rds_port = "5432"
rds_family = "postgres15"
rds_engine = "postgres"
rds_engine_version = "15.4"
rds_name = "dbpostgresql"
rds_class = "db.t3.micro"
rds_strorage = "10"


#========================ssm=====================================
source_services = ["api"]

#=======================ACM=====================================
domain_name_lb = "devops.donnytran.com"

#=======================cf-fe=========================
cf_cert_arn = "arn:aws:acm:us-east-1:115228050885:certificate/0c9c7e80-e373-4089-9087-857adaa5ab9e"
domain_cf_fe = "fe.devops.donnytran.com"
domain_cf_static = "static.devops.donnytran.com"
domain_cf_samplenode = "khai.devops.donnytran.com"

#=======================ecs-scale===============================
ecs_service = [
  {
    service_name = "testingservice"
    container_name = "ugc" 
    command = "pwd"
    container_port = "80"
    desired_count = "1"
    task_cpu = "512"
    task_ram = "2048"
    min_containers = "1"
    max_containers = "1"
    auto_scaling_target_value_cpu = "2"
    auto_scaling_target_value_ram = "4"
    healthcheck_path = "/"
    priority = "1"
    use_load_balancer = true
    use_s3_for_data = true
    host_header = "ugc.devops.donnytran.com"
  },
  {
    service_name = "testingweb"
    container_name = "web" 
    command = "pwd"
    container_port = "80"
    desired_count = "1"
    task_cpu = "512"
    task_ram = "2048"
    min_containers = "1"
    max_containers = "1"
    auto_scaling_target_value_cpu = "2"
    auto_scaling_target_value_ram = "4"
    healthcheck_path = "/"
    priority = "2"
    use_load_balancer = true
    use_s3_for_data = true
    host_header = "web.devops.donnytran.com"
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

#=======================CI/CD====================================
codebuild_image = "BUILD_GENERAL1_SMALL"
codebuild_compute_type = "aws/codebuild/standard:5.0"
github_repos = [
  { 
    service = ["testingservice"],
    name = "testingnewpipeline", 
    branch="dev", 
    buildspec_variables=[
      {
        key   = "REPOSITORY_URI"
        value = "115228050885.dkr.ecr.us-east-1.amazonaws.com/dev-ugc-geotech-ugc"
      }
    ] 
  },
  { 
    service = ["testingweb"],
    name = "testweb", 
    branch="feature", 
    buildspec_variables=[
      {
        key   = "REPOSITORY_URI"
        value = "115228050885.dkr.ecr.us-east-1.amazonaws.com/dev-ugc-geotech-web"
      }
    ] 
  }
]

github_repos_fe = [
  { 
    service = ["samplenode"],
    name = "samplenode", 
    branch="main", 
    buildspec_variables=[
      {
        key   = "FE_BUCKET"
        value = "dev-ugc-geotech-samplenode"
      },
      {
        key   = "CLOUDFRONT_DISTRIBUTION_ID"
        value = "E2TSRDW28DXU4E"
      }
    ] 
  }
]

#=========================ACM for lb==================================
dns_cert_arn = "arn:aws:acm:us-east-1:115228050885:certificate/230f0f65-1658-4493-89d6-47922ce4c896"