generate "remote_state" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.7.0"
    }
  }
}
EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}
EOF
}

inputs = {
  subscription_id = "6df41622-41b3-4bc3-bc18-8debd3d2820b"
  resource_group  = "rg-fincorp"
  location        = "West Europe"

  tags = {
    Environment = "prod"
  }
}
