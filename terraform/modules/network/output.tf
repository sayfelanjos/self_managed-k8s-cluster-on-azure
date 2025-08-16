output "worker_nodes_subnet_id" {
  value = azurerm_subnet.worker_nodes_subnet.id
}

output "control_planes_subnet_id" {
  value = azurerm_subnet.control_planes_subnet.id
}

output "lb_master_address_pool_id" {
  value = azurerm_lb_backend_address_pool.control_planes_bkeapool.id
}

output "lb_worker_address_pool_id" {
  value = azurerm_lb_backend_address_pool.worker_nodes_bkeapool.id
}

output "control_plane_endpoint" {
  description = "The endpoint for the Control Plane of the Kubernetes cluster."
  value       = azurerm_public_ip.control_planes_lb_pip.ip_address
}

output "worker_public_ip" {
  value = azurerm_public_ip.worker_nodes_lb_pip.ip_address
}

output "control_planes_subnet_nsg_id" {
  value = azurerm_network_security_group.control_planes_subnet_nsg.id
}