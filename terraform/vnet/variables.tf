variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "self-managed-k8s-cluster-rg"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "West Europe"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "example-network"
}

variable "vnet_address_space" {
  type = list(string)
  description = "Address space for the virtual network"
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
  default     = "internal"
}

variable "internal_subnet_address_prefixes" {
  type = list(string)
  description = "Address prefixes for the subnet"
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.0.2/24"]
}

variable "subnet_address_prefix" {
  type = list(string)
  description = "Address prefix for the subnet"
  default = ["10.0.2.0/24"]
}

variable "vmss_name" {
  type        = string
  description = "Name of the virtual machine scale set"
  default     = "example-vmss"
}

variable "vmss_sku" {
  type        = string
  description = "SKU for the virtual machine scale set"
  default     = "Standard_F2"
}

variable "vmss_instances" {
  type        = number
  description = "Number of instances in the scale set"
  default     = 1
}

variable "admin_username" {
  type        = string
  description = "Username for the VM admin account"
  default     = "adminuser"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key for the VM admin account"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wWK73dCr+jgQOAxNsHAnNNNMEMWOHYEccp6wJm2gotpr9katuF/ZAdou5AaW1C61slRkHRkpRRX9FA9CYBiitZgvCCz+3nWNN7l/Up54Zps/pHWGZLHNJZRYyAB6j5yVLMVHIHriY49d/GZTZVNB8GoJv9Gakwc/fuEZYYl4YDFiGMBP///TzlI4jhiJzjKnEvqPFki5p2ZRJqcbCiF4pJrxUQR/RXqVFQdbRLZgYfJ8xGB878RENq3yQ39d8dVOkq4edbkzwcUmwwwkYVPIoDGsYLaRHnG+To7FvMeyO7xDVQkMKzopTQV8AuKpyvpqu0a9pWOMaiCyDytO7GGN you@me.com"
}

variable "image_publisher" {
  type        = string
  description = "Publisher of the VM image"
  default     = "Canonical"
}

variable "image_offer" {
  type        = string
  description = "Offer of the VM image"
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  type        = string
  description = "SKU of the VM image"
  default     = "22_04-lts"
}

variable "image_version" {
  type        = string
  description = "Version of the VM image"
  default     = "latest"
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "Storage account type for OS disk"
  default     = "Standard_LRS"
}

variable "os_disk_caching" {
  type        = string
  description = "Caching type for OS disk"
  default     = "ReadWrite"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the resources"
  default     = {
    Environment = "Development"
    Project     = "KubernetesCluster"
  }
}

