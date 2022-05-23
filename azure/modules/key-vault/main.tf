data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  tags                = var.tags

  dynamic "access_policy" {
    for_each = var.permissions

    content {
      tenant_id       = data.azurerm_client_config.current.tenant_id
      object_id       = access_policy.value.object_id
      key_permissions = access_policy.value.key_permissions
    }
  }
}
