variable "openstack_provider_config" {
  description = "Openstack provider configuration"
  type = object({
    user_name   = string
    tenant_name = string
    password    = string
    auth_url    = string
    region      = string
    insecure    = bool
  })
  sensitive = true
}

variable "your_ssh_key_pair_name" {
  description = "The name of your previously created key pair"
  type        = string
  sensitive   = true
}

variable "rke2_token" {
  description = "Kubernetes RKE2 token"
  type        = string
  default     = "test"
}
