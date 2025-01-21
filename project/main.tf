# INFRASTRUCTURE

module "public_net" {
  source    = "./modules/network"
  name      = "public_net"
  cidr      = "192.168.0.0/24"
  is_public = true
}

module "internal_net" {
  source = "./modules/network"
  name   = "internal_net"
  cidr   = "192.168.1.0/24"
}

module "ssh_secgroup" {
  source    = "./modules/secgroup"
  name      = "ssh_secgroup"
  allow_ssh = true
}

# INSTANCES

module "controller" {
  source = "./modules/instance"

  instance_name = "controller"
  networks = [
    module.public_net.id,
    module.internal_net.id,
  ]
  secgroups              = [module.ssh_secgroup.name]
  cloudinit_config       = file("${path.module}/data/cloud-init.yaml")
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
  is_public              = true
}

module "nodes" {
  count  = 3
  source = "./modules/instance"

  instance_name          = "node${count.index}"
  networks               = [module.internal_net.id]
  secgroups              = [module.ssh_secgroup.name]
  cloudinit_config       = file("${path.module}/data/cloud-init.yaml")
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
}

# OUTPUTS

output "networks" {
  value = [
    module.public_net,
    module.internal_net,
  ]
}

output "instances" {
  value = [
    module.controller,
    module.nodes,
  ]
}

data "openstack_networking_network_v2" "public" {
  name = "public"
}
