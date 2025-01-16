variable "compute_image_name" {
  description = "Compute instance image name"
  type        = string
  default     = "Debian-12"
}

variable "compute_flavor_name" {
  description = "Compute instance flavor name"
  type        = string
  default     = "m1.small"
}

variable "your_ssh_key_pair_name" {
  description = "The name of your previously created key pair"
  type        = string
  sensitive   = true
}

variable "external_network_name" {
  description = "External network name"
  type        = string
  default     = "public"
}

variable "internal_network_name" {
  description = "Internal network name"
  type        = string
  default     = "default"
}
