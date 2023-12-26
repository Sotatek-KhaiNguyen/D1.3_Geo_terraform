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
}

module "ecr" {
  source = "../modules/ecr"
  common = local.common
  image_tag_mutability = var.image_tag_mutability
}