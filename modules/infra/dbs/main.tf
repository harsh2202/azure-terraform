
provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rgname" {
  name = "DefaultResourceGroup-EUS"
}

# # Virtual Network for private endpoint 
# resource "azurerm_virtual_network" "this" {
#   name                = var.virtual_network_name
#   resource_group_name = azurerm_resource_group.this.name
#   location            = azurerm_resource_group.this.location
#   address_space       = var.vnet_address_space
# }

# resource "azurerm_subnet" "this" {
#   name                                           = var.subnet_name
#   resource_group_name                            = azurerm_resource_group.this.name
#   virtual_network_name                           = azurerm_virtual_network.this.name
#   address_prefixes                               = var.subnet_prefixes
#   enforce_private_link_endpoint_network_policies = true
# }


module "azure_cosmos_db" {
  source              = "Azure/cosmosdb/azurerm"
  resource_group_name = data.azurerm_resource_group.rgname.name
  location            = data.azurerm_resource_group.rgname.location
  cosmos_account_name = var.cosmos_account_name
  cosmos_api          = var.cosmos_api
  sql_dbs             = var.sql_dbs
  sql_db_containers   = var.sql_db_containers
  private_endpoint = {
    "pe_endpoint" = {
      dns_zone_group_name             = var.dns_zone_group_name
      dns_zone_rg_name                = data.azurerm_private_dns_zone.rgname.resource_group_name
      is_manual_connection            = false
      name                            = var.pe_name
      private_service_connection_name = var.pe_connection_name
      subnet_name                     = azurerm_subnet.this.name
      vnet_name                       = azurerm_virtual_network.this.name
      vnet_rg_name                    = azurerm_resource_group.this.name
    }
  }
  depends_on = [
    azurerm_resource_group.this,
    azurerm_virtual_network.this,
    azurerm_subnet.this,
    azurerm_private_dns_zone.dns_zone,
    azurerm_private_dns_zone_virtual_network_link.dns_zone
  ]
}