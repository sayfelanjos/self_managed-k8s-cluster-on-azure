output "master_public_ip" {
  value = module.k8s-cluster.master_public_ip
}

output "worker_public_ip" {
  value = module.k8s-cluster.worker_public_ip
}