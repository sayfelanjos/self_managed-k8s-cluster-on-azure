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