terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "azure-prod-eu-west-kms"
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

module "key_vault" {
  source = "../../modules/key-vault"

  for_each = var.key_vaults

  name                = each.value.name
  resource_group_name = var.resource_group
  location            = var.location
  permissions         = each.value.permissions
  tags                = var.tags
}
