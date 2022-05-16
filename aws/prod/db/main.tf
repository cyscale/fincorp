terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "aws-prod-eu-west-rds"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.13.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "fincorp"
    workspaces = {
      name = "aws-prod-eu-west-vpc"
    }
  }
}

module "rds" {
  source                 = "../../modules/rds"
  storage_size           = 20
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t3.micro"
  name                   = "fincorp"
  user                   = var.db_user
  pass                   = var.db_pass
  identifier             = "fincorp-prod-db"
  subnet_group_name      = data.terraform_remote_state.vpc.outputs.db_subnet_group_name
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.security_groups["rds"]]
  skip_snapshot          = true
}
