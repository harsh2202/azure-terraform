
#
module "storage" {
    source = "../modules/infra/storage"
}

#tf apply -var-file=../env/dev/Network/dev.tfvars   OR    tf apply --target=module.network -var-file=../env/dev/Network/dev.tfvars(Specific Module)

module "network" {
    source = "../modules/infra/network"
    location = var.location
    env = var.env
    prefix = var.prefix
    subnet_cidr_suffix = var.subnet_cidr_suffix
    spoke_subnet_counts = var.spoke_subnet_counts
    spoke_vnet_cidr_prefix = var.spoke_vnet_cidr_prefix
    subnet_count_per_vnet = var.subnet_count_per_vnet
    spoke_vnet_names = var.spoke_vnet_names
    hub_vnet_cidr = var.hub_vnet_cidr
    tags = var.tags
}

module "vms" {
    source = "../modules/infra/vms"
    prefix = var.prefix
}

module "aks" {
#    depends_on = [ module.network ]
    source     = "../modules/infra/aks"
    location = var.location
    prefix = var.prefix
}