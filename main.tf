terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-resources"
    storage_account_name = "storacctterraform"
    container_name       = "statecam"
    key                  = "cam"
  }
}
provider "azurerm" {
  features {}
}

# Create Resource Group

resource "azurerm_resource_group" "Resource_Group" {
  name = "${var.prefix}-${var.location}-RG"
  location = var.location
  tags = var.tags
}

# Create hub VNet
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "${var.prefix}-Hub-VNet-${var.env}"
  address_space       = [var.hub_vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.Resource_Group.name
  tags = var.tags
}

# Create spoke VNets and subnets
resource "azurerm_virtual_network" "spoke_vnet" {
  count               = length(var.spoke_vnet_names)
  name                = "${var.spoke_vnet_names[count.index]}-${var.env}"
  address_space       = ["${var.spoke_vnet_cidr_prefix}.${count.index}.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.Resource_Group.name
  tags = var.tags
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  count                   = length(var.spoke_vnet_names)
  name                    = "hub-to-spoke-${count.index + 1}"
  resource_group_name     = azurerm_resource_group.Resource_Group.name
  virtual_network_name    = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet[count.index].id
  

  allow_forwarded_traffic    = true
  allow_gateway_transit      = false
  use_remote_gateways        = false
}

resource "random_id" "subnet_suffix" {
  byte_length = 4
  prefix = "tf"
  count = 4
}

resource "azurerm_subnet" "subnets-app" {
  count                 = var.subnet_count_per_vnet
  name                  = "subnet-${count.index + 1}-${random_id.subnet_suffix[count.index].hex}"
  virtual_network_name  = azurerm_virtual_network.spoke_vnet[0].name
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  address_prefixes      = [cidrsubnet(azurerm_virtual_network.spoke_vnet[0].address_space[0], 8, count.index)]
}                         

resource "azurerm_subnet" "subnets-db" {
  count                 = var.subnet_count_per_vnet
  name                  = "subnet-${count.index + 1}-DB"
  virtual_network_name  = azurerm_virtual_network.spoke_vnet[1].name
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  address_prefixes      = [cidrsubnet(azurerm_virtual_network.spoke_vnet[1].address_space[0], 8, count.index)]
} 

resource "azurerm_subnet" "subnets-pe" {
  count                 = var.subnet_count_per_vnet
  name                  = "subnet-${count.index + 1}-PE"
  virtual_network_name  = azurerm_virtual_network.spoke_vnet[2].name
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  address_prefixes      = [cidrsubnet(azurerm_virtual_network.spoke_vnet[2].address_space[0], 8, count.index)]
} 

resource "azurerm_subnet" "subnets-security" {
  count                 = var.subnet_count_per_vnet
  name                  = "subnet-${count.index + 1}-Security"
  virtual_network_name  = azurerm_virtual_network.spoke_vnet[3].name
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  address_prefixes      = [cidrsubnet(azurerm_virtual_network.spoke_vnet[3].address_space[0], 8, count.index)]
} 