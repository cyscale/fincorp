resource "azurerm_service_plan" "this" {
  name                = "plan-fincorp-prod-eu-west"
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "this" {
  name                = "webapp-fincorp-prod-eu-west"
  resource_group_name = var.resource_group
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = false
    application_stack {
      python_version = "3.9"
    }
  }

  tags = var.tags
}
