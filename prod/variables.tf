variable "project" {
  type = string
  default = "Geotechnologies_UGC_App"
  description = "Project name"
}

variable "env" {
  type = string
  default = "prod"
  description = "Environment name"
}

variable "region" {
  type = string
  default = "us-east-1"
  description = "ap-southeast-1"
}

variable "account_id" {
  type = string
  default = "115228050885"
}

variable "image_tag_mutability" {
    type = string
    default = "IMMUTABLE"
}
