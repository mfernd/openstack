# Secgroup
resource "openstack_networking_secgroup_v2" "secgroup" {
  name = var.name
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rules" {
  for_each          = { for index, rule in var.ingress_rules : rule.port => rule }
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = each.value.protocol
  port_range_min    = each.value.port
  port_range_max    = each.value.port
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}
