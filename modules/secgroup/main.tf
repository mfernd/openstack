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

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_internal_ingress" {
  count             = var.allow_all_for_internal.allow ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = ""
  remote_ip_prefix  = var.allow_all_for_internal.cidr
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_internal_egress" {
  count             = var.allow_all_for_internal.allow ? 1 : 0
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = ""
  remote_ip_prefix  = var.allow_all_for_internal.cidr
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}
