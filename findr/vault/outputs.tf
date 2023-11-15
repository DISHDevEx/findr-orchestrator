output "vault_endpoint" {
  description = "Endpoint for accessing Vault"
  value = helm_release.vault.status.load_balancer.ingress[0].ip

}
