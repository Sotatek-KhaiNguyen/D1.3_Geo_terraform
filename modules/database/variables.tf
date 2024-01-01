variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
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

variable "network" {
    type = object({
        vpc_id = string
        subnet_ids = list(string)
        #sg_container = string
    })
}

variable "sg_ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
    }))
}   


variable "rds_port" {
  type = string
}

variable "rds_family" {
    type = string
}