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

# variable "vpc_id" {
#   type = string
# }

# variable "subnet_id" {
#   type = string
# }

# variable "network" {
#   type = object({
#     vpc_id = string
#     subnet_ids = string
#     security_group = string
#   })
# }

# variable "iam_credentials" {
#   type = object({
#     key = string
#     secret = string
#   })
# }

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
# variable "network" {
#   type = object({
#     vpc_id_private = string
#     subnet_ids = list(string)
#     sg_container = string
#   })
# }

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

# variable "port" {
#   type = string
# }

variable "ports" {
  type = list(string)
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

variable "rds_class" {
    type = string
}

variable "rds_strorage" {
    type = string
}

# variable "sg_ingress_rules" {
#     type = list(object({
#       from_port   = number
#       to_port     = number
#       protocol    = string
#       cidr_block  = string
#       description = string
#     }))
#     default     = [
#         {
#           from_port   = 22
#           to_port     = 22
#           protocol    = "tcp"
#           cidr_block  = "0.0.0.0/0"
#           description = "test"
#         },
#         {
#           from_port   = 3306
#           to_port     = 3306
#           protocol    = "tcp"
#           cidr_block  = "0.0.0.0/0"
#           description = "test"
#         },
#     ]
# }


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

#=======================ecs-base=============================
variable "vpc_id_private" {
  type = string
}

#=======================ecs-scale=============================
variable "ecs_scale_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "command" {
  type = string
}

variable "container_port" {
  type = number
}

variable "desired_count" {
  type = string
}

variable "task_cpu" {
  type = string
}

variable "task_ram" {
  type = string
}

variable "min_containers" {
  type = string
}

variable "max_containers" {
  type = string
}

variable "auto_scaling_target_value_cpu" {
  type = string
}

variable "auto_scaling_target_value_ram" {
  type = string
}

variable "sg_lb" {
  type = string
}

variable "tg_arn" {
  type = string
}

# variable "ecs" {
#   type = object({
#     role_auto_scaling = string
#     role_execution = string
#     role_ecs_service = string
#     ecs_cluster_id = string
#     ecs_cluster_name = string
#   })
# }

#====================VPC==============================
variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
}

variable "public_subnet_numbers" {
  type = map(number)
  description = "Map of AZ to a number that should be used for public subnets"
}
 
variable "private_subnet_numbers" {
  type = map(number)
  description = "Map of AZ to a number that should be used for private subnets"
}