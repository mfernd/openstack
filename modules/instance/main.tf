resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_id       = data.openstack_compute_flavor_v2.small.id
  key_pair        = data.openstack_compute_keypair_v2.kp.name
  security_groups = var.secgroups
  user_data       = var.cloudinit_config

  dynamic "network" {
    for_each = var.networks
    content {
      uuid = network.value
    }
  }

  block_device {
    uuid                  = data.openstack_images_image_v2.debian.id
    source_type           = "image"
    volume_size           = 20
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  count = var.is_public ? 1 : 0
  pool  = data.openstack_networking_network_v2.external_network.name
}

resource "openstack_networking_floatingip_associate_v2" "public_ip" {
  count       = var.is_public ? 1 : 0
  floating_ip = openstack_networking_floatingip_v2.floatip_1[count.index].address
  port_id     = data.openstack_networking_port_v2.instance_port[count.index].id
}
