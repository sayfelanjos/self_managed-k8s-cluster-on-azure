output "public_subnet_id" {
  value = azurerm_subnet.k8s_public_subnet.id
}
output "lb_master_address_pool_id" {
  value = azurerm_lb_backend_address_pool.k8s_master_bkeapool.id
}
output "lb_worker_address_pool_id" {
  value = azurerm_lb_backend_address_pool.k8s_worker_bkeapool.id
}