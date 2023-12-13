data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}
data "azurerm_storage_account" "knixat_tfstate" {
  name                = var.storage_account_name["name"]
  resource_group_name = var.storage_account_name["resource_group_name"]
}
data "azurerm_client_config" "current" {}