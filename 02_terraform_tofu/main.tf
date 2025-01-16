module "infrastructure" {
  source = "./modules/infrastructure"
}

module "instance" {
  source = "./modules/instance"

  your_ssh_key_pair_name = var.your_ssh_key_pair_name
}

output "instance" {
  value = module.instance
}
