# network <-> subnet [<-> router <-> public]

resource "openstack_networking_network_v2" "network" {
  name           = var.name
  admin_state_up = "true"
}


resource "openstack_networking_subnet_v2" "subnet" {
  name       = var.name
  network_id = openstack_networking_network_v2.network.id
  cidr       = var.cidr
  ip_version = 4
}

# if var.is_public

resource "openstack_networking_router_v2" "router" {
  count               = var.is_public ? 1 : 0
  name                = var.name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  count     = var.is_public ? 1 : 0
  router_id = openstack_networking_router_v2.router[count.index].id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

data "openstack_networking_network_v2" "public" {
  name = "public"
}
