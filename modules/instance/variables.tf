// # Required

variable "instance_name" {
  description = "Compute instance name"
  type        = string
}

variable "networks" {
  description = "List of network uids"
  type        = list(string)
}

variable "your_ssh_key_pair_name" {
  description = "The name of your previously created key pair"
  type        = string
  sensitive   = true
}

// # Optional

variable "secgroups" {
  description = "List of secgroup names"
  type        = list(string)
  default     = []
}

variable "cloudinit_config" {
  description = "Content to put in the user_data cloud init"
  type        = string
  nullable    = true
}

variable "is_public" {
  description = "Content to put in the user_data cloud init"
  type        = bool
  default     = false
}

variable "compute_image_name" {
  description = "Compute instance image name"
  type        = string
  default     = "Ubuntu-24.10"
}

variable "compute_flavor_name" {
  description = "Compute instance flavor name"
  type        = string
  default     = "m1.small"
}
