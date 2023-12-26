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
  network = {
    vpc_id = "${var.vpc_id}"
    subnet_id = "${var.subnet_id}"
    security_group = "${var.security_group}"
  }
}

module "ecr" {
  source = "../modules/ecr"
  common = local.common
  image_tag_mutability = var.image_tag_mutability
}

module "ec2" {
  source = "../modules/bastionhost"
  common = local.common
  network = local.network
  subnet_id = var.subnet_id
  #security_group = local.security_group
  iam_credentials = var.iam_credentials
  ssh_public_key = var.ssh_public_key
}

module "pipeline" {
  source = "../modules/cicd/codepipeline"
  common = local.common
  repo = var.repo
  git_url = var.git_url
  branch = var.branch
  name = var.name
  pipeline = var.pipeline
}

module "codebuild" {
  source = "../modules/cicd/codebuild"
  common = local.common
  name = var.name
  role_codebuild = var.role_codebuild
}

module "redis" {
  source = "../modules/cache"
  common = local.common
  network = var.network
  redis_engine_version = var.redis_engine_version
  num_cache_nodes = var.num_cache_nodes
  node_type = var.node_type
  port = var.port
}

module "rds" {
  source = "../modules/database"
  common = local.common
  network = var.network
  rds_engine = var.rds_engine
  rds_engine_version = var.rds_engine_version
  rds_name = var.rds_name
  rds_username = var.rds_username
  rds_password = var.rds_password
  rds_class = var.rds_class
  rds_strorage = var.rds_strorage
  rds_port = var.rds_port
  rds_family = var.rds_family
}

module "natgateway" {
  source = "../modules/natgateway"
  common = local.common
  subnet_id = var.subnet_id
}

module "hostzone_cdn" {
  source = "../modules/route53/route53cdn"
  hosted_zone_public_id = var.hosted_zone_public_id
  domain_name = var.domain_name
  cf_s3_domain_name = var.cf_s3_domain_name
  cf_s3_hosted_zone_id = var.cf_s3_hosted_zone_id
}

module "hostzone_lb" {
  source = "../modules/route53/route53lb"
  hosted_zone_public_id = var.hosted_zone_public_id
  domain_name = var.domain_name
  lb_domain_name = var.lb_domain_name
  lb_hosted_zone_id = var.lb_hosted_zone_id
}