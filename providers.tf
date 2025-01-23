terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "3.0.0"
    }
  }
}

provider "openstack" {
  user_name   = var.openstack_provider_config.user_name
  tenant_name = var.openstack_provider_config.tenant_name
  password    = var.openstack_provider_config.password
  auth_url    = var.openstack_provider_config.auth_url
  region      = var.openstack_provider_config.region
  insecure    = var.openstack_provider_config.insecure
  # cloud       = "<YOUR_ENTRY_IN clouds.yaml>"
}
