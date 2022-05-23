terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "azure-prod-eu-west-storage"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "fincorp"
    workspaces = {
      name = "azure-prod-eu-west-vpc"
    }
  }
}
