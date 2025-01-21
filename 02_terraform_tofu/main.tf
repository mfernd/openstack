module "infrastructure" {
  source = "./modules/infrastructure"

  network_name = "mystack"
}

module "instance" {
  source = "./modules/instance"

  your_ssh_key_pair_name = var.your_ssh_key_pair_name
  internal_network_id    = module.infrastructure.network_id
  secgroup_name          = module.infrastructure.secgroup_name
}

output "infrastructure" {
  value = module.infrastructure
}

output "instance" {
  value = module.instance
}
