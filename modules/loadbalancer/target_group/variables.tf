variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
}

variable "health_check_path" {
    type = string
}

variable "network" {
  type = object({
    vpc_id = string
  })
}

# variable "container_port" {
#     type = string
# }

variable "aws_lb_listener_arn" {
  type = string
}

variable "host_header" {
  type = string
}

variable "priority" {
  type = string
}