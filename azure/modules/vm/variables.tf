variable "resource_group" {
  type = string
}

variable "location" {
  type = string
}

variable "name" {
  type        = string
  description = "If, for example, you provide 'test' as the name, the created resource will be named vm-test, nic-test, etc."
}

variable "subnet" {
  type = string
}

variable "vm_size" {
  type        = string
  description = "See output from `az vm list-sizes --location <location, e.g. westeurope> --output table`"
}

variable "tags" {
  type = map(string)
}
