resource "azurerm_storage_account" "hatorsstracct1" {
  name                     = var.hatorsstracct1["name"]
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = var.hatorsstracct1["account_tier"]
  account_replication_type = var.hatorsstracct1["account_replication_type"]
}
resource "azurerm_storage_container" "statefiles" {
  name                  = var.storage_account_container["name"]
  storage_account_name  = data.azurerm_storage_account.knixat_tfstate.name
  container_access_type = var.storage_account_container["container_access_type"]
}
resource "azurerm_key_vault" "keyvault" {
  name                       = "hatorskeyvault"
  location                   = data.azurerm_resource_group.main.location
  resource_group_name        = data.azurerm_resource_group.main.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  sku_name                   = "standard"
}
resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example"
  target_resource_id = azurerm_key_vault.example.id
  storage_account_id = azurerm_storage_account.example.id

  enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}