terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "aws-prod-eu-west-vpc"
    }
  }
}

module "vpc" {
  source           = "../../modules/vpc"
  cidr_block       = var.vpc_cidr
  security_groups  = var.security_groups
  public_sn_count  = 2
  private_sn_count = 3
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
}
