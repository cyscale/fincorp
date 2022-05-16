terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "aws-prod-eu-west-vpc"
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
