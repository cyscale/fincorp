locals {
  any_ip = "0.0.0.0/0"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Security group for public instances"
      ingress = {
        open = {
          from_port   = 0
          to_port     = 0
          protocol    = -1
          cidr_blocks = [var.access_ip]
        }
        http = {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = [local.any_ip]
        }
      }
    }
    rds = {
      name        = "rds_sg"
      description = "Security group for database"
      ingress = {
        mysql = {
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          cidr_blocks = [var.cidr_block]
        }
      }
    }
  }
}
