location = "southeastasia"
hub_vnet_cidr = "172.16.0.0/16"
spoke_vnet_cidr_prefix = "172.16"
spoke_vnet_names = ["vnet-app", "vnet-db", "vnet-pe", "vnet-security"]
prefix = "Orange_Application"
env = "QA"
spoke_subnet_counts = 4
subnet_count_per_vnet = 4
subnet_cidr_suffix = "/24"
tags = {
  environment = "QA"
  owner       = "Alice Smith"
  application     = "Orange"
}