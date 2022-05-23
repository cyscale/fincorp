variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "permissions" {
  type = map(object({
    object_id       = string
    key_permissions = list(string)
  }))
}
