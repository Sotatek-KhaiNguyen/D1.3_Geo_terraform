variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
}

variable "network" {
  type = object({
    vpc_id = string
    subnet_ids = list(string)
    #sg_container = string
  })
}


# variable "vpc_id" {
#     type = string
# }

# variable "subnet_ids" {
#     type = list(string)
# }

# variable "sg_container" {
#     type = string
# }

variable "redis_engine_version" {
    type = string
}

variable "engine" {
  type = string
}

variable "node_type" {
    type = string
}

variable "parameter_group_name" {
  type = string
}

# variable "port" {
#     type = string
# }

variable "ports" {
  type = list(string)
}