# INFRASTRUCTURE

module "public_net" {
  source    = "./modules/network"
  name      = "public_net"
  is_public = true
}

module "internal_net" {
  source = "./modules/network"
  name   = "internal_net"
}

module "internal_secgroup" {
  source    = "./modules/secgroup"
  name      = "internal_secgroup"
  allow_ssh = true
}

# MACHINES

module "load_balancer" {
  source = "./modules/instance"

  instance_name = "load_balancer"
  networks = [
    module.public_net.id,
    module.internal_net.id,
  ]
  secgroups              = [module.internal_secgroup.name]
  cloudinit_config       = file("${path.module}/data/cloud-init.yaml")
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
  is_public              = true
}

module "frontend0" {
  source = "./modules/instance"

  instance_name          = "frontend0"
  networks               = [module.internal_net.id]
  secgroups              = [module.internal_secgroup.name]
  cloudinit_config       = file("${path.module}/data/cloud-init.yaml")
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
}

module "frontend1" {
  source = "./modules/instance"

  instance_name          = "frontend1"
  networks               = [module.internal_net.id]
  secgroups              = [module.internal_secgroup.name]
  cloudinit_config       = file("${path.module}/data/cloud-init.yaml")
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
}

module "backend" {
  source = "./modules/instance"

  instance_name          = "backend"
  networks               = [module.internal_net.id]
  secgroups              = [module.internal_secgroup.name]
  cloudinit_config       = file("${path.module}/data/cloud-init.yaml")
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
}

# OUTPUTS

output "networks" {
  value = [module.internal_net]
}

output "instances" {
  value = [
    module.load_balancer,
    module.frontend0,
    module.frontend1,
    module.backend,
  ]
}

data "openstack_networking_network_v2" "public" {
  name = "public"
}
