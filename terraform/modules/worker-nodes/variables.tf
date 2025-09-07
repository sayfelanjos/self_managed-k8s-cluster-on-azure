variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where all resources in this example should be created."
  type        = string
}

variable "worker_nodes_name" {
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
variable "worker_nodes_subnet_id" {
  description = "The ID of the subnet where the virtual machine scale set will be deployed."
  type        = string
}
variable "lb_worker_address_pool_id" {
  description = "The ID of the load balancer backend address pool."
  type        = string
}
variable "control_plane_endpoint" {
  type        = string
  description = "The control plane endpoint."
}
variable "pod_network_cidr" {
  description = "The CIDR block for the pod network."
  type        = string
}
variable "kv_uri" {
  description = "The URI of the Azure Key Vault."
  type        = string
}
variable "kv_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}
variable "worker_nodes_user_assigned_identity_id" {
  type        = string
  description = "The user-assigned identity ID to be assigned to the worker nodes."
}
variable "worker_nodes_user_assigned_identity_client_id" {
  type        = string
  description = "The user-assigned identity client ID to be assigned to the worker nodes."
}
variable "subscription_id" {
  type        = string
  description = "The subscription ID to use for the control plane nodes."
}
variable "ansible_core_version" {
  type        = string
  default     = "2.16.2"
  description = "The version of Ansible core to be used in the control plane setup."
}
variable "k8s_base_node_image_id" {
  type = string
}