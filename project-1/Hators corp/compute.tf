# APP SERVICE PLAN
resource "azurerm_service_plan" "hatorscorp-service_plan" {
  for_each = var.app_service_plan
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = each.value.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}
resource "azurerm_linux_web_app" "webapp" {
  for_each = var.hotorscorp-webapp   
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = azurerm_service_plan.hatorscorp-service_plan[each.value.app_service_plan].location
  service_plan_id     = azurerm_service_plan.hatorscorp-service_plan[each.value.app_service_plan].id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }
}
# WEB APPS
resource "azurerm_app_service_source_control" "mah-source-control" {
  for_each = var.hotorscorp-webapp
  app_id                 = azurerm_linux_web_app.webapp[each.key].id
  repo_url               = each.value.repo_url
  branch                 = each.value.branch
 }
# # resource "azurerm_source_control_token" "sc_token" {
# #   for_each = var.hotorscorp-webapp
# #   type  = each.value.type
# #   token = each.value.token
# # }
# #VIRTUAL MACHINES
resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each = var.linux_virtual_machine
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.value.network_interface_card].id,
  ]

  admin_ssh_key {
    username   = each.value.admin_ssh_key.username
    public_key = file(each.value.admin_ssh_key.public_key)
  }

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}
resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each = var.windows_virtual_machine
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  network_interface_ids = [
    azurerm_network_interface.windows_nic[each.value.network_interface_card].id,
  ]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}
### fucntion app
resource "azurerm_linux_function_app" "function_app" {
  for_each = var.function_apps
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  storage_account_name       = azurerm_storage_account.hatorsstracct1.name
  storage_account_access_key = azurerm_storage_account.hatorsstracct1.primary_access_key
  service_plan_id            = azurerm_service_plan.hatorscorp-service_plan[each.value.app_service_plan].id

  site_config {
   
  }
}