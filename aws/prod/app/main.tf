terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "aws-prod-eu-west-app"
    }
  }
}

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
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

data "terraform_remote_state" "iam" {
  backend = "remote"
  config = {
    organization = "fincorp"
    workspaces = {
      name = "aws-prod-iam"
    }
  }
}
