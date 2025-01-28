variable "name" {
  description = "Name of the secgroup, usually the project name."
  type        = string
}

variable "ingress_rules" {
  description = "List of rules for ingress."
  type = list(object({
    protocol = string
    port     = number
  }))
  default = []
}

variable "allow_all_for_internal" {
  description = "Allow all communication for the internal network"
  type = object({
    allow = bool
    cidr  = string
  })
  default = {
    allow = true
    cidr  = "192.168.0.0/24"
  }
}
