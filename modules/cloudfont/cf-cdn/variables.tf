variable "common" {
  type = object({
    project = string
    env = string
    region = string
    account_id = string
  })
}

variable "cf_cert_arn" {
  type = string
}

variable "cdn_domain" {
  type = string
}