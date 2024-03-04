location = "westeurope"
hub_vnet_cidr = "172.16.0.0/16"
spoke_vnet_cidr_prefix = "172.16"
spoke_vnet_names = ["vnet-app", "vnet-db", "vnet-pe", "vnet-security"]

prefix = "Apple_Application"
env = "dev"
spoke_subnet_counts = 4
subnet_count_per_vnet = 4
subnet_cidr_suffix = "/24"
tags = {
  environment = "dev"
  owner       = "Alice Smith"
  application     = "Apple"
}
