variable "create_resource_group" {
  type     = bool
  default  = true
  nullable = false
}

variable "location" {
  type    = string
  default = "westus"
}

variable "resource_group_name" {
  type    = string
  default = null
}

variable "vnet_location" {
  type    = string
  default = "eastus"
}
