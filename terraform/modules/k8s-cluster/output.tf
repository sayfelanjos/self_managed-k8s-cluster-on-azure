output "public_subnet_id" {
  value = module.vnet.public_subnet_id
}

output "private_subnet_id" {
  value = module.vnet.private_subnet_id
}

output "master_public_ip" {
  value = module.vnet.master_public_ip
}

output "worker_public_ip" {
  value = module.vnet.worker_public_ip
}

output "control_plane_principal_id" {
  description = "The Principal ID for the Control Plane's Managed Identity."
  value       = module.k8s-control-plane.control_plane_principal_id
}

output "worker_node_principal_id" {
  description = "The Principal ID for the Worker Node's Managed Identity."
  value       = module.k8s-worker-nodes.worker_node_principal_id
}