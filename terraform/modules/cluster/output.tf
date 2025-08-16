output "worker_nodes_subnet_id" {
  value = module.vnet.worker_nodes_subnet_id
}

output "control_planes_subnet_id" {
  value = module.vnet.control_planes_subnet_id
}

output "control_plane_endpoint" {
  description = "The endpoint for the Control Plane of the Kubernetes cluster."
  value       = module.vnet.control_plane_endpoint
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