resource "azurerm_storage_account" "this" {
  name                     = "stfincorpprodeuwest"
  location                 = var.location
  resource_group_name      = var.resource_group
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  for_each = var.containers

  name                  = each.value.name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value.access_type
}
