output "master_public_ip" {
  value = module.k8s-cluster.master_public_ip
}

output "worker_public_ip" {
  value = module.k8s-cluster.worker_public_ip
}

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "The URI of the Azure Key Vault."
}