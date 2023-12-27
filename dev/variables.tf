variable "project" {
  type = string
  description = "Project name"
}

variable "env" {
  type = string
  description = "Environment name"
}

variable "region" {
  type = string
}

variable "account_id" {
  type = string
}

#=======================ECR=====================================
variable "image_tag_mutability" {
    type = string
}


#=======================EC2=====================================
variable "ssh_public_key" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group" {
  type = string
}

# variable "network" {
#   type = object({
#     vpc_id = string
#     subnet_ids = string
#     security_group = string
#   })
# }

variable "iam_credentials" {
  type = object({
    key = string
    secret = string
  })
}

#=======================ci/cd=====================================
variable "pipeline" {
  type = object({
    #role_codebuild = string
    role_codepipeline = string
    #role_event_pipeline = string
    pipeline_bucket = string
  })
}



# variable "buildspec_url" {
#   type = string
# }

# variable "cicd" {
#   type = object({
#     codebuild = string
#     codedeploy = string
#   })
# }

variable "git_url" {
  type = string
}

variable "branch" {
  type = string
}

variable "repo" {
  type = string
}

variable "name" {
  type = string
}
variable "role_codebuild" {
  type = string
}

#=======================redis cache=====================================
variable "network" {
  type = object({
    vpc_id_private = string
    subnet_ids = list(string)
    sg_container = string
  })
}

# variable "subnet_ids" {
#     type = list(string)
# }

# variable "sg_container" {
#   type = string
#   default = "default"
# }

variable "redis_engine_version" {
  type = string
}

variable "num_cache_nodes" {
  type = string
}

variable "node_type" {
  type = string
}

variable "port" {
  type = string
}

#=======================rds=====================================
variable "rds_port" {
  type = string
}

variable "rds_family" {
    type = string
}

variable "rds_engine" {
    type = string
}

variable "rds_engine_version" {
    type = string
}

variable "rds_name" {
    type = string
}

variable "rds_username" {
    type = string
}

variable "rds_password" {
    type = string
}

variable "rds_class" {
    type = string
}

variable "rds_strorage" {
    type = string
}

#========================route53cdn=================
variable "hosted_zone_public_id" {
    type = string
}

variable "domain_name" {
    type = string
}

variable "cf_s3_domain_name" {
    type = string
}

variable "cf_s3_hosted_zone_id" {
    type = string
}

#========================route53lb=================
variable "lb_domain_name" {
    type = string
}

variable "lb_hosted_zone_id" {
    type = string
}


#=======================cf-cdn=========================
variable "cf_cert_arn" {
  type = string
}

variable "cdn_domain" {
  type = string
}

#=======================cf-cdn=========================
variable "cf_static_page_name" {
  type = string
}