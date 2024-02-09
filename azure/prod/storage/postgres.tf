resource "azurerm_private_dns_zone" "this" {
  name                = "fincorp.postgres.database.azure.com"
  resource_group_name = var.resource_group

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "postgres-fincorp-prod-eu-west"
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = data.terraform_remote_state.vpc.outputs.vnet
  resource_group_name   = var.resource_group

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                   = "postgres-fincorp-prod-eu-west"
  resource_group_name    = var.resource_group
  location               = var.location
  version                = "13"
  delegated_subnet_id    = data.terraform_remote_state.vpc.outputs.subnets["postgres"]
  private_dns_zone_id    = azurerm_private_dns_zone.this.id
  administrator_login    = "psqladmin"
  administrator_password = "CyscaleDemo1!"

  storage_mb = 32768

  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.this]

  tags = var.tags

  lifecycle {
    ignore_changes = [
      zone
    ]
  }
}
