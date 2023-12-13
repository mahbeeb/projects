terraform {
  backend "azurerm" {
    resource_group_name  = "knixat-demo"
    storage_account_name = "knixatlogs"
    container_name       = "habeebullahi-mahmoud-tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
