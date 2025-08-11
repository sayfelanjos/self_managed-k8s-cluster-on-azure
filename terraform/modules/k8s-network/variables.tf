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
variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}
variable "public_subnet_name" {
  description = "The name of the subnet."
  type        = string
}
variable "public_subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefix for the internal subnets."
}
variable "private_subnet_name" {
  description = "The name of the subnet."
  type        = string
}
variable "private_subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefix for the internal subnets."
}
variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual network."
}

variable "master_nodes_name" {
  type        = string
  description = "The name of the master nodes."
}