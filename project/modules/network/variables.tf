variable "name" {
  description = "Name of the network, usually the project name"
  type        = string
}

variable "is_public" {
  description = "If network is connected to public"
  type        = bool
  default     = false
}
