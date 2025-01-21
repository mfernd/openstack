variable "name" {
  description = "Name of the secgroup, usually the project name"
  type        = string
}

variable "allow_ssh" {
  description = "Add secgroup rule to allow SSH"
  type        = bool
  default     = false
}
