variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The Azure region where all resources should be created."
}

# variable "control_plane_principal_id" {
#   type = string
#   description = "The principal ID of the control plane service principal."
# }
#
# variable "worker_nodes_principal_id" {
#   type = string
#   description = "The principal ID of the worker nodes service principal."
# }