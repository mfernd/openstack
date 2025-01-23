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
