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
  networks               = [module.public_net.id, module.internal_net.id]
  secgroups              = [module.secgroup0.name]
  is_public              = true
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
  cloudinit_config = templatefile("${path.module}/assets/cloud-init.tftpl", {
    playbook_name = "ansible/rke2_controller.yaml",
    token         = var.rke2_token
  })
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
    # module.nodes,
  ]
}

data "openstack_networking_network_v2" "public" {
  name = "public"
}
