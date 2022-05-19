terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "gcp-prod-eu-west-etl"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "fincorp"
    workspaces = {
      name = "gcp-prod-eu-west-vpc"
    }
  }
}
