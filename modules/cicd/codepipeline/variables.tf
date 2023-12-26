variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
}

variable "pipeline" {
  type = object({
    #role_codebuild = string
    role_codepipeline = string
    #role_event_pipeline = string
    pipeline_bucket = string
  })
}

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
