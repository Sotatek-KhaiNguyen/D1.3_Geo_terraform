variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
}

variable "subnet_id" {
    type =  string
}

# variable "allocation_id" {
#     type = string
# }