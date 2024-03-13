
provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rgname" {
  name = "DefaultResourceGroup-EUS"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-k8s"
  location            = data.azurerm_resource_group.rgname.location
  resource_group_name = data.azurerm_resource_group.rgname.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size = "B1ls"
    #vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}