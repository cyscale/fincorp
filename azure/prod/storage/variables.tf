variable "subscription_id" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "containers" {
  type = map(object({
    name        = string
    access_type = string
  }))
}
