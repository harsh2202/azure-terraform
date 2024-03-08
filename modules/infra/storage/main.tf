
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