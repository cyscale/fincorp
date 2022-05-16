variable "cidr_block" {
  default = "10.123.0.0/16"
}

variable "public_sn_count" {
  default = 2
}

variable "public_cidrs" {
  default = ["10.123.1.0/24", "10.123.3.0/24"]
}

variable "private_sn_count" {
  default = 3
}

variable "private_cidrs" {
  default = ["10.123.2.0/24", "10.123.4.0/24", "10.123.6.0/24"]
}

variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
