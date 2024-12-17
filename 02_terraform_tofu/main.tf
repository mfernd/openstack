# Resource: myinstance
## compute instance
resource "openstack_compute_instance_v2" "myinstance" {
  name            = "myinstance"
  image_id        = data.openstack_images_image_v2.debian.id
  flavor_id       = data.openstack_compute_flavor_v2.small.id
  key_pair        = data.openstack_compute_keypair_v2.kp.name
  security_groups = [data.openstack_networking_secgroup_v2.common_secgroup.name]

  network {
    name = data.openstack_networking_network_v2.int_network.name
  }
}

data "openstack_networking_port_v2" "myinstance-port" {
  fixed_ip = openstack_compute_instance_v2.myinstance.access_ip_v4
}

## volumes
resource "openstack_compute_volume_attach_v2" "attached" {
  instance_id = openstack_compute_instance_v2.myinstance.id
  volume_id   = openstack_blockstorage_volume_v3.myvol.id
}

resource "openstack_blockstorage_volume_v3" "myvol" {
  name = "myvol"
  size = 6 # in gigabytes
}

## create floating ip
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = data.openstack_networking_network_v2.ext_network.name
}

## associate it to compute instance port
resource "openstack_networking_floatingip_associate_v2" "public_ip" {
  floating_ip = openstack_networking_floatingip_v2.floatip_1.address
  port_id     = data.openstack_networking_port_v2.myinstance-port.id
}

# ---------
# Data
## Fetch Image
data "openstack_images_image_v2" "debian" {
  name = var.compute_image_name
}

## Fetch Compute Flavor
data "openstack_compute_flavor_v2" "small" {
  name = var.compute_flavor_name
}

## Fetch Key Pair
data "openstack_compute_keypair_v2" "kp" {
  name = var.your_ssh_key_pair_name
}

## Get external network
data "openstack_networking_network_v2" "ext_network" {
  name = var.external_network_name
}

## Get internal network
data "openstack_networking_network_v2" "int_network" {
  name = var.internal_network_name
}

## Fetch Security Group
data "openstack_networking_secgroup_v2" "common_secgroup" {
  name = "common"
}
