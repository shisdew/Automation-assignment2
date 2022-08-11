#Modules
module "resource_group" {
  source         = "./modules/resource_group"
  resource_group = "assignment2-RG"
  location       = "canadacentral"
}

module "network" {
  source         = "./modules/network"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
}

module "common" {
  source         = "./modules/common"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
  depends_on     = [module.resource_group]
}

module "vmlinux" {
  source         = "./modules/vmlinux"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
  nb_count       = 2
  depends_on     = [module.network]
  linux_name     = "linux"



  subnet_id           = module.network.subnet.id
  storage_account_uri = module.common.storage_account.primary_blob_endpoint
}

module "vmwindows" {
  source              = "./modules/vmwindows"
  resource_group      = module.resource_group.resource_group.name
  location            = module.resource_group.resource_group.location
  depends_on          = [module.network]
  windows_name        = "wvm"
  subnet_id           = module.network.subnet.id
  storage_account_uri = module.common.storage_account.primary_blob_endpoint
}

module "datadisk" {
  source         = "./modules/datadisk"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
  depends_on = [
    module.vmlinux,
    module.vmwindows
  ]
  windows_name = module.vmwindows.Windows_hostname
  windows_id   = module.vmwindows.Windows_vm.id
  linux_name = {
    linux-vm-1 = 0
    linux-vm-2 = 1
  }
  linux_id = [module.vmlinux.Linux_id]

}

module "loadbalancer" {
  source         = "./modules/loadbalancer"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
  linux_name = {
    linux-vm-1 = 0
    linux-vm-2 = 1
  }
  linux_network_interface_id = [module.vmlinux.Linux_network_interface_id]
  linux_pip_id               = [module.vmlinux.Linux_public_ip_addresses_id]
  depends_on = [
    module.vmlinux,
    module.vmwindows,
    module.network
  ]
}

module "database" {
  source         = "./modules/database"
  resource_group = module.resource_group.resource_group.name
  location       = module.resource_group.resource_group.location
  depends_on     = [module.network]
}