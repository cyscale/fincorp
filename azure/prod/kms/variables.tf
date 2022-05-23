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

variable "key_vaults" {
  type = map(object({
    name = string
    permissions = map(object({
      object_id       = string
      key_permissions = list(string)
    }))
  }))
}
