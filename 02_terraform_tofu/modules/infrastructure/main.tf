# public <-> router <-> subnet <-> network

resource "openstack_networking_router_v2" "router" {
  name                = var.network_name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = var.network_name
  network_id = openstack_networking_network_v2.network.id
  cidr       = "192.168.0.0/24"
  ip_version = 4
}

resource "openstack_networking_network_v2" "network" {
  name           = var.network_name
  admin_state_up = "true"
}

# Secgroup
resource "openstack_networking_secgroup_v2" "secgroup" {
  name = var.network_name
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}
