

# output "spoke_vnet_ids" {
#   description = "IDs of the Azure Spoke VNets"
#   value       = azurerm_virtual_network.spoke_vnet[*].id
# }


output "spoke_vnet_names" {
  value = [for vnet in azurerm_virtual_network.spoke_vnet : vnet.name]
}


output "hub_vnet_id" {
  value = azurerm_virtual_network.hub_vnet.id
}

output "spoke_vnet_ids" {
  value = [for vnet in azurerm_virtual_network.spoke_vnet : vnet.id]
}

output "subnet_name" {
  value = azurerm_subnet.subnets-app[*].name
}
