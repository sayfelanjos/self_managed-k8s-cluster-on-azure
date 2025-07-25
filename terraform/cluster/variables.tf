variable "resource_group_name" {
  description = "The name of the resource group where the resources will be created."
  type        = string
}
variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}
variable "worker_nodes_name" {
  description = "The name of the virtual machine scale set."
  type        = string
}
variable "master_nodes_name" {
  description = "The name of the virtual machine scale set."
  type        = string
}
variable "vmss_sku" {
  description = "The SKU for the virtual machine scale set."
  type        = string
}
variable "vmss_instance_count" {
  description = "The number of instances in the virtual machine scale set."
  type        = number
}
variable "source_image_sku" {
  description = "The SKU of the source image for the virtual machines."
  type        = string
}
variable "source_image_publisher" {
  description = "The publisher of the source image for the virtual machines."
  type        = string
}
variable "source_image_offer" {
  description = "The offer of the source image for the virtual machines."
  type        = string
}
variable "source_image_version" {
  description = "The version of the source image for the virtual machines."
  type        = string
}
variable "admin_username" {
  description = "The admin username for the virtual machines."
  type        = string
}
variable "admin_ssh_key" {
  description = "The public key for SSH access to the virtual machines."
  type        = string
}
variable "os_disk_storage_account_type" {
  description = "The storage account type for the OS disk."
  type        = string
}
variable "os_disk_caching" {
  description = "The caching type for the OS disk."
  type        = string
}
variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
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
  description = "Address prefixes for the subnet"
}
variable "private_subnet_name" {
  description = "The name of the subnet."
  type        = string
}
variable "private_subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the resources"
  default = {
    Environment = "Development"
    Project     = "KubernetesCluster"
  }
}
