terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "azure-prod-eu-west-neo"
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

module "vm" {
  source         = "../../modules/vm"
  resource_group = var.resource_group
  location       = var.location
  name           = "prod-neo-banks"
  subnet         = data.terraform_remote_state.vpc.outputs.subnets["dmz"]
  vm_size        = "Standard_B1s"
  tags           = var.tags
}
