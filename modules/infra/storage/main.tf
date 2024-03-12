provider "azurerm" {
  features {}
}

####### TF APPLY ################


data "azurerm_resource_group" "rgname" {
  name = "DefaultResourceGroup-EUS"
}

# Creating the Storage account

resource "azurerm_storage_account" "storage" {
  name                      = "storage01tfstate"
  resource_group_name       = data.azurerm_resource_group.rgname.name
  location                  = var.location  
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

resource "azurerm_storage_container" "statefile" {
  name                 = "statefiles"
  storage_account_name = azurerm_storage_account.storage.name
}

