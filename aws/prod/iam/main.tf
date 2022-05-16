terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "aws-prod-iam"
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
