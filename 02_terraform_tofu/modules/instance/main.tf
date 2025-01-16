resource "openstack_compute_instance_v2" "myinstance" {
  name            = "myinstance"
  image_id        = data.openstack_images_image_v2.debian.id
  flavor_id       = data.openstack_compute_flavor_v2.small.id
  key_pair        = data.openstack_compute_keypair_v2.kp.name
  security_groups = [var.secgroup_name]

  network {
    name = data.openstack_networking_network_v2.int_network.name
  }
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = data.openstack_networking_network_v2.ext_network.name
}

resource "openstack_networking_floatingip_associate_v2" "public_ip" {
  floating_ip = openstack_networking_floatingip_v2.floatip_1.address
  port_id     = data.openstack_networking_port_v2.myinstance-port.id
}
