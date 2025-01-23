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

  instance_name = "controller"
  networks = [
    module.public_net.id,
    module.internal_net.id,
  ]
  secgroups              = [module.secgroup0.name]
  cloudinit_config       = file("${path.module}/assets/cloud-init-server-node.yaml")
  your_ssh_key_pair_name = var.your_ssh_key_pair_name
  is_public              = true
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
