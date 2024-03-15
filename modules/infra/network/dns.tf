# Private DNS Zone for SQL API 

resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = azurerm_resource_group.Resource_Group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone" {
  name                  = "${var.prefix}-DNS_ZONE-${var.env}"
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = azurerm_virtual_network.this.id
  registration_enabled  = false
}