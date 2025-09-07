# variable "resource_group_name" {
#   type = string
# }

# variable "location" {
#   type = string
# }
#
# variable "client_id" {
#   type = string
# }
#
# variable "client_secret" {
#   type = string
# }
#
# variable "subscription_id" {
#   type = string
# }
#
# variable "tenant_id" {
#   type = string
# }

# variable "key_vault_name" {
#   type = string
# }

# variable "pod_network_cidr" {
#   type    = string
#   default = "10.244.0.0/16"
# }
#
# variable "control_plane_endpoint" {
#   type    = string
# }
#
variable "ansible_core_version" {
  type    = string
  default = "2.16.2"
}