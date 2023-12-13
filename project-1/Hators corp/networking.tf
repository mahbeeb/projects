resource "azurerm_virtual_network" "vnet1" {
  for_each = var.vnet
  name                = each.value.name
  address_space       = each.value.address_space
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}
resource "azurerm_subnet" "subnet1" {
  for_each = var.subnets
  name                 = each.value.name
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet1[each.value.virtual_network].name
  address_prefixes     = each.value.address_prefixes
}
resource "azurerm_network_interface" "windows_nic" {
 for_each = var.windows_nic
  name                = each.value.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = azurerm_subnet.subnet1[each.value.ip_configuration.subnet_id].id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }
}
resource "azurerm_network_interface" "linux_nic" {
  for_each = var.linux_nic
  name                = each.value.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = azurerm_subnet.subnet1[each.value.ip_configuration.subnet_id].id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }
}
resource "azurerm_public_ip" "publicips" {
  for_each = var.publicip
  name                = each.value.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}
resource "azurerm_bastion_host" "example" {
  for_each = var.bastion_host
  name                = each.value.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                 = each.value.ip_configuration.name
    subnet_id            = azurerm_subnet.subnet1[each.value.ip_configuration.subnet_id].id
    public_ip_address_id = azurerm_public_ip.publicips[each.value.ip_configuration.public_ip].id
  }
}