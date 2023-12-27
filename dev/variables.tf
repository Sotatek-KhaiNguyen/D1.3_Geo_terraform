variable "project" {
  type = string
  default = "geotechnologies-ugc-app"
  description = "Project name"
}

variable "env" {
  type = string
  default = "dev"
  description = "Environment name"
}

variable "region" {
  type = string
  default = "ap-southeast-1"
  description = "ap-southeast-1"
}

variable "account_id" {
  type = string
  default = "115228050885"
}

#=======================ECR=====================================
variable "image_tag_mutability" {
    type = string
    default = "MUTABLE"
}


#=======================EC2=====================================
variable "ssh_public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1HNnCuTxWgUhCPxr5UKm90BH4i4XymHNfNh3eZXSOGkbW+oDvZstBdczUWgcHAExi2nA2NV9Lkgb01h02DUkgL2hIlbMRNd02Y+MBjYUtvLvdIz3hXulOkqxFsAGF/yk2aKOVrd254T7C1xyHxi1XGdVHb1Bc61qagT32aFArAorbzBC5/9XTzhGkMr0pOp0qtxU+y/e+YO/gAAxYTvCPaFJKiFLI3+yCX0C4dA2kny3sGva2/ky7K9nvIS3EeZu8NkY3m2Cq7196EqNPmWvkhLdIktNxplZZOxmItFBkomWsqY6l1Cxw2Bv2n2KfWued7f9ms8MN3/OyGCapnnw7tcgnwULFd+45tMUqh4RaIiCFw9oFg6x9RHCXMzFnIQl74Zc4uS8I4lTcoctsf2BAhylD4wXB94OANBuhJVNLL2Bj9jVm8Gjtjtv4+IfqnI7v8jyP1lBR0SrPvzkDO53WJT6h8QIH1OA++w0upR14D/DW6jKdqpsoWdMr//U0Gmc= tanvn32@tanvn32-MS-7C67"
}

variable "vpc_id" {
  type = string
  default = "vpc-0f6f1f927ab619182"
}

variable "subnet_id" {
  type = string
  default = "	subnet-00141605612999d66"
}

variable "security_group" {
  type = string
  default = "default"
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
  default = "git@github.com:Sotatek-KhaiNguyen/terraform_D1.3_Geotechnologies.git"
}

variable "branch" {
  type = string
  default = "main"
}

variable "repo" {
  type = string
  default = "terraform_D1.3_Geotechnologies"
}

variable "name" {
  type = string
  default = "test"
}
variable "role_codebuild" {
  type = string
  default = "arn:aws:iam::115228050885:role/test"
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
  default = "redis"

}

variable "num_cache_nodes" {
  type = string
  default = "1"
}

variable "node_type" {
  type = string
  default = "cache.t4g.medium"
}

variable "port" {
  type = string
  default = 6379
}

#=======================rds=====================================
variable "rds_port" {
  type = string
  default = "3306"
}

variable "rds_family" {
    type = string
    default = "mysql8.0"
}

variable "rds_engine" {
    type = string
    default = "mysql"
}

variable "rds_engine_version" {
    type = string
    default = "8.0"
}

variable "rds_name" {
    type = string
    default = "api"
}

variable "rds_username" {
    type = string
    default = "root"
}

variable "rds_password" {
    type = string
    default = "123456"
}

variable "rds_class" {
    type = string
    default = "db.t3.xlarge"
}

variable "rds_strorage" {
    type = string
    default = "100"
}

#========================route53cdn=================
variable "hosted_zone_public_id" {
    type = string
    default = "test"
}

variable "domain_name" {
    type = string
    default = "test.sotatek.com"
}

variable "cf_s3_domain_name" {
    type = string
    default = "s3.sotatek.com"
}

variable "cf_s3_hosted_zone_id" {
    type = string
    default = "zone_id_test"
}

#========================route53lb=================
variable "lb_domain_name" {
    type = string
    default = "lb.sotatek.com"
}

variable "lb_hosted_zone_id" {
    type = string
    default = "zone_id_test"
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