
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "terraform-resources"
#     storage_account_name = "storacctterraform"
#     container_name       = "statecam"
#     key                  = "terraform"
#   }
# }
provider "azurerm" {
  features {}
}

# Creating the Storage account

resource "azurerm_resource_group" "common_RG" {
    name = var.rgName  
    location = var.location
}

resource "random_string" "rstr" {
  length = 8
  special = true
  upper = true
}

resource "azurerm_storage_account" "storage" {
  name                      = "${var.rgName}${random_string.rstr.result}"
  resource_group_name       = azurerm_resource_group.common_RG.name
  location                 = var.location   
  account_tier             = "Standard"
  account_replication_type  = "LRS"
  
}

resource "azurerm_storage_container" "statefile" {
  name                 = "statefiles"
  storage_account_name = azurerm_storage_account.storage.name
   
}