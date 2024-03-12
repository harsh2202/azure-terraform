variable "location" {
  description = "Azure region where the resources will be created"
}

variable "hub_vnet_cidr" {
  description = "CIDR block for the hub VNet"
}

variable "spoke_vnet_cidr_prefix" {
  description = "Prefix for each spoke VNet CIDR block"
}

variable "env" {
  type = string
  description = "environment for particular application"  
}

variable "spoke_vnet_names" {
  description = "Number of spoke VNets to create"
  type = list(string)
}

variable "spoke_subnet_counts" {
  description = "Number of spoke VNets to create"
}

variable "subnet_cidr_suffix" {
  description = "Suffix for subnet CIDR blocks (e.g., /24, /25, etc.)"
}

variable "prefix" {
  description = "env prefix"
}

variable "subnet_count_per_vnet" {
  description = "Number of subnets per VNet"
}

variable "tags" {
  type = map(string)
  
}

