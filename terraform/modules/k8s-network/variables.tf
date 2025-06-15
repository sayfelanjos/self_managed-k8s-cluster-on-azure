variable "vnet_name" {
  type        = string
    description = "The name of the virtual network."
}
variable "resource_group_name" {
    type        = string
    description = "The name of the resource group where the virtual network will be created."
}
variable "location" {
    type        = string
    description = "The Azure region where the resources will be created."
}
variable "address_space" {
    type        = list(string)
    description = "The address space for the virtual network."
}
variable "internal_subnet_address_prefixes" {
    type        = list(string)
    description = "The address prefix for the internal subnets."
}
variable "tags" {
    type        = map(string)
    description = "A map of tags to assign to the virtual network."
}