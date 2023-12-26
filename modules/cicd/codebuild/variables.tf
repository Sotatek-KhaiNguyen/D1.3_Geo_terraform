variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
}

variable "name" {
  type = string
}

variable "role_codebuild" {
  type = string
}

# variable "pipeline" {
#   type = object({
#     role_codebuild = string
#     role_codepipeline = string
#     role_event_pipeline = string
#     pipeline_bucket = string
#   })
# }

# variable "buildspec_url" {
#   type = string
# }

# variable "network" {
#   type = object({
#     vpc_id = string
#     subnet_ids = list(string)
#     sg_container = string
#   })
# }