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

variable "vpc_id" {
  type = string
}

variable "port" {
    type = string
}

variable "aws_lb_listener_arn" {
  type = string
}

variable "protocol" {
    type = string
}

variable "target_type" {
    type = string
}

variable "host_header" {
  type = string
}