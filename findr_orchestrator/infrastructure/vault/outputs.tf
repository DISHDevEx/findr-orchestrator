/**
 * Vault URL
*/ 
output "vault_url" {
  description = "Instruction to find the external IP address of Harbor's LoadBalancer"
  value       = "Use 'kubectl get svc -n vault -o wide' to find the external IP address of Vault's LoadBalancer service."
}

/**
 * Consul release name
*/ 
output "consul_release_name" {
  description = "Name of the Consul release"
  value = helm_release.consul.name
}

/**
 * Vault release name
*/
output "vault_release_name" {
  description = "Name of the Vault release"
  value = helm_release.vault.name
}
