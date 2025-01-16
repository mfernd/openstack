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
  network_id = var.internal_network_id
}

## Get port of created instance
data "openstack_networking_port_v2" "myinstance-port" {
  device_id  = openstack_compute_instance_v2.myinstance.id
  network_id = data.openstack_networking_network_v2.int_network.id
}
