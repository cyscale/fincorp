output "storage_account" {
  value = azurerm_storage_account.this.name
}

output "blob_endpoint" {
  value = azurerm_storage_account.this.primary_blob_endpoint
}

output "st_access_key" {
  value     = azurerm_storage_account.this.primary_access_key
  sensitive = true
}

output "containers" {
  value = { for k, v in azurerm_storage_container.this : k => v.id }
}

output "postgres_fqdn" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}
