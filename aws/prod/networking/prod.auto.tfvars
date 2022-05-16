vpc_cidr = "10.124.0.0/16"

security_groups = {
  public = {
    name        = "public_sg"
    description = "Security group for public instances"
    ingress = {
      open = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
      http = {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
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
        cidr_blocks = ["10.124.0.0/16"]
      }
    }
  }
}
