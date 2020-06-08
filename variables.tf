variable "vnet_name" {
  description = "Name of the vnet to create"
  default     = "acctvnet"
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default     = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  default     = ["subnet1", "subnet2", "subnet3"]
}

variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)

  default = {
  }
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ENV = "test"
  }
}

variable "subnet_service_endpoints" {
  description = "a list of service endpoints to add to the subnet. Each element of the list is a list of service endpoints to be applied to subnet of the same index"
  default     = [[], ]
}


variable "subnet_enforce_private_link_endpoint" {
  description = "Enable or Disable network policies for the private link endpoint on the created subnets. Default value is false. Conflicts with enforce_private_link_service_network_policies."
  default     = false
}

variable "subnet_enforce_private_link_service" {
  description = "Enable or Disable network policies for the private link service on the created subnets. Default valule is false. Conflicts with enforce_private_link_endpoint_network_policies"
  default     = false
}
