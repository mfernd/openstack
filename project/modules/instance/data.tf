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

## Get port of created instance
data "openstack_networking_port_v2" "instance_port" {
  count      = var.is_public ? 1 : 0
  depends_on = [openstack_compute_instance_v2.instance]
  fixed_ip   = openstack_compute_instance_v2.instance.access_ip_v4
}

## Get public network
data "openstack_networking_network_v2" "external_network" {
  name = "public"
}
