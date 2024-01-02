terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.31.0"
    }
  } 
}

locals {
  common = {
    project = "${var.project}"
    env = "${var.env}"
    region = "${var.region}"
    account_id = "${var.account_id}"
  }
  # network = {
  #   vpc_id = "${var.vpc_id}"
  #   subnet_id = "${var.subnet_id}"
  #   security_group = "${var.security_group}"
  # }

}

#========================tfstate management========================================
terraform {
  backend "s3" {
    bucket         = "terraform-state-ugc-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
  }
}



#============================================================================

module "vpc" {
  source = "../modules/vpc"
  common = local.common
  vpc_cidr = var.vpc_cidr
  public_subnet_numbers = var.public_subnet_numbers
  private_subnet_numbers = var.private_subnet_numbers
}

# module "ecr" {
#   source = "../modules/ecr"
#   common = local.common
#   image_tag_mutability = var.image_tag_mutability
# }

module "ec2" {
  source = "../modules/bastionhost"
  common = local.common
  ssh_public_key = var.ssh_public_key
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_ids[0]
}

# module "pipeline" {
#   source = "../modules/cicd/codepipeline"
#   common = local.common
#   repo = var.repo
#   git_url = var.git_url
#   branch = var.branch
#   name = var.name
#   pipeline = var.pipeline
# }

# module "codebuild" {
#   source = "../modules/cicd/codebuild"
#   common = local.common
#   name = var.name
#   role_codebuild = var.role_codebuild
# }

module "redis" {
  source = "../modules/cache"
  common = local.common
  #network = var.network
  redis_engine_version = var.redis_engine_version
  num_cache_nodes = var.num_cache_nodes
  node_type = var.node_type
  ports = var.ports
  network = {
    vpc_id = module.vpc.vpc_id
    subnet_ids = [module.vpc.private_subnet_ids[0]]
  }
}

module "rds" {
  source = "../modules/database"
  common = local.common
  rds_engine = var.rds_engine
  rds_engine_version = var.rds_engine_version
  rds_name = var.rds_name
  rds_class = var.rds_class
  rds_strorage = var.rds_strorage
  rds_port = var.rds_port
  rds_family = var.rds_family
  network = {
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnet_ids
  }
}

# module "natgateway" {
#   source = "../modules/natgateway"
#   common = local.common
#   subnet_id = var.subnet_id
# }

# module "hostzone_cdn" {
#   source = "../modules/route53/route53cdn"
#   hosted_zone_public_id = var.hosted_zone_public_id
#   domain_name = var.domain_name
#   cf_s3_domain_name = var.cf_s3_domain_name
#   cf_s3_hosted_zone_id = var.cf_s3_hosted_zone_id
# }

# module "hostzone_lb" {
#   source = "../modules/route53/route53lb"
#   hosted_zone_public_id = var.hosted_zone_public_id
#   domain_name = var.domain_name
#   lb_domain_name = var.lb_domain_name
#   lb_hosted_zone_id = var.lb_hosted_zone_id
# }

# module "cdn_domain" {
#   source = "../modules/cloudfont/cf-cdn"
#   common = local.common
#   cf_cert_arn = var.cf_cert_arn
#   cdn_domain =  var.cdn_domain
# }

# module "cf-static-page" {
#   source = "../modules/cloudfont/cf-static-page"
#   common = local.common
#   cf_static_page_name = var.cf_static_page_name
#   cf_cert_arn = var.cf_cert_arn
# }

# module "ecs-base" {
#   source = "../modules/ecs/ecs-base"
#   common = local.common
#   vpc_id_private = var.vpc_id_private
# }

# module "ecs-scale" {
#   source = "../modules/ecs/ecs-with-scale"
#   common = local.common
#   network = var.network
#   ecs_scale_name = var.ecs_scale_name
#   container_name = var.container_name
#   command = var.command
#   container_port = var.container_port
#   desired_count = var.desired_count
#   task_cpu = var.task_cpu
#   task_ram = var.task_ram
#   min_containers = var.min_containers
#   max_containers = var.max_containers
#   auto_scaling_target_value_cpu = var.auto_scaling_target_value_cpu
#   auto_scaling_target_value_ram = var.auto_scaling_target_value_ram
#   sg_lb = var.sg_lb
#   tg_arn = var.tg_arn
#   ecs = {
#     role_auto_scaling = module.ecs-base.role_auto_scaling
#     role_execution = module.ecs-base.role_execution
#     role_ecs_service = module.ecs-base.role_ecs_service
#     ecs_cluster_id = module.ecs-base.ecs_cluster_id
#     ecs_cluster_name = module.ecs-base.ecs_cluster_name
#   }
# }

module "pipelinebase" {
  source = "../modules/pipelinebase"
  common = local.common
}


module "codepipeline_api" {
  for_each = { for github in var.github_repos : github["name"] => github }

  source = "../modules/pipeline-api"
  common = local.common
  #github_repos           = var.github_frontend_repos
  github_repos           = var.github_repos
  codebuild_image        = var.codebuild_image
  codebuild_compute_type = var.codebuild_compute_type
  codebuild_buildspec    = var.codebuild_buildspec
  OAuthToken             = var.OAuthToken
  bucketName             = module.pipelinebase.s3_bucket
  codepipelineRoleArn    = module.pipelinebase.codepipeline_role_arn
  gitBranch              = each.value.branch
  gitRepo                = each.value.name
  organization           = each.value.organization
  codebuildRoleArn       = module.pipelinebase.codebuild_role_arn
  codedeployRoleArn      = module.pipelinebase.codedeploy_role_arn
  lambda_endpoint = module.pipelinebase.lambda_endpoint
  lambda_secret   = module.pipelinebase.secret_key
  #buildspec_file  = "./buildspec/example.tpl"
}