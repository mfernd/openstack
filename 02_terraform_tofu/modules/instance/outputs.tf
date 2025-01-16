output "external_ip" {
  depends_on = [openstack_networking_floatingip_associate_v2.public_ip]
  value      = openstack_networking_floatingip_associate_v2.public_ip.floating_ip
}

output "internal_ip" {
  depends_on = [openstack_compute_instance_v2.myinstance]
  value      = openstack_compute_instance_v2.myinstance.access_ip_v4
}
