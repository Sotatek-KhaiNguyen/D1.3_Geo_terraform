variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
}

variable "source_services" {
  type = set(string)
}