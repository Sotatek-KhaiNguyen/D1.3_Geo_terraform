variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
}
variable "table_name" {
  type = string
}

variable "hash_key" {
  type = string
}