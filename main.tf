# INFRASTRUCTURE

module "network" {
  source    = "./modules/network"
  name      = "network"
  cidr      = "192.168.0.0/24"
  is_public = true
}

module "secgroup0" {
  source = "./modules/secgroup"
  name   = "secgroup0"
  ingress_rules = [
    {
      protocol = "tcp"
      port     = 22
    },
    {
      protocol = "tcp"
      port     = 80
    },
    {
      protocol = "tcp"
      port     = 443
    },
  ]
}

# INSTANCES

module "controller" {
  source = "./modules/instance"

  instance_name          = "controller"
  compute_flavor_name    = "m1.medium"
  networks               = [module.network.id]
  secgroups              = [module.secgroup0.name]
  is_public              = true
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
  cloudinit_config = templatefile("${path.module}/assets/cloud-init.tftpl", {
    playbook_name   = "ansible/rke2_controller.yaml",
    token           = var.rke2_token,
    controller_ip   = null,
    argocd_password = var.argocd_password,
  })
}

module "nodes" {
  count  = 3
  source = "./modules/instance"

  instance_name          = "node${count.index}"
  compute_flavor_name    = "m1.medium"
  networks               = [module.network.id]
  secgroups              = [module.secgroup0.name]
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
  cloudinit_config = templatefile("${path.module}/assets/cloud-init.tftpl", {
    playbook_name   = "ansible/rke2_node.yaml",
    token           = var.rke2_token,
    controller_ip   = module.controller.internal_ip,
    argocd_password = "",
  })
}

# OUTPUTS

output "networks" {
  value = [
    module.network,
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
