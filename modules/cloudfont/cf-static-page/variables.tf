variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  }
  )
}

variable "cf_static_page_name" {
  type = string
}

variable "cf_cert_arn" {
  type = string
}
