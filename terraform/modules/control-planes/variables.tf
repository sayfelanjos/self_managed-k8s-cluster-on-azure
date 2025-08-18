variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
variable "location" {
  description = "The Azure region where all resources in this example should be created."
  type        = string
}

variable "control_planes_name" {
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

variable "admin_username" {
  description = "The admin username for the virtual machines."
  type        = string
}

variable "admin_ssh_key" {
  description = "The public key for SSH access to the virtual machines."
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

variable "source_image_sku" {
  description = "The SKU of the source image for the virtual machines."
  type        = string
}

variable "source_image_version" {
  description = "The version of the source image for the virtual machines."
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
variable "control_planes_subnet_id" {
  description = "The ID of the subnet where the virtual machine scale set will be deployed."
  type        = string
}
variable "lb_master_address_pool_id" {
  description = "The ID of the load balancer backend address pool."
  type        = string
}

variable "control_plane_endpoint" {
  description = "The endpoint for the control plane, typically the load balancer IP or DNS name."
  type        = string
}

variable "pod_network_cidr" {
  description = "The CIDR block for the pod network."
  type        = string
}

variable "kv_uri" {
  description = "The URI of the Azure Key Vault."
  type        = string
}

variable "control_planes_subnet_nsg_id" {
  type        = string
  description = "The ID of the network security group for the master nodes."
}
