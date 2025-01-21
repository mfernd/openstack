output "name" {
  depends_on = [openstack_compute_instance_v2.instance]
  value      = openstack_compute_instance_v2.instance.name
}

output "external_ip" {
  depends_on = [openstack_networking_floatingip_associate_v2.public_ip]
  value      = var.is_public ? openstack_networking_floatingip_associate_v2.public_ip[0].floating_ip : null
}

output "internal_ip" {
  depends_on = [openstack_compute_instance_v2.instance]
  value      = openstack_compute_instance_v2.instance.access_ip_v4
}
