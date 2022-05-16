locals {
  region            = "eu-west-1"
  availability_zone = "${local.region}a"
  tags = {
    Environment = "prod"
  }
}
