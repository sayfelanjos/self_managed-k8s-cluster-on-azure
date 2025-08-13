variable "resource_group_name" {
  description = "The name of the resource group where the Kubernetes cluster is located."
  type        = string
}

variable "location" {
  description = "The Azure region where the Kubernetes cluster is deployed."
  type        = string
}