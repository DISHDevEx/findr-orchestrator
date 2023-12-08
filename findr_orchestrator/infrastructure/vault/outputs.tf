/**
 * Consul service URL
*/
output "consul_service_url" {
  value = helm_release.consul.manifest.values.service.type == "LoadBalancer" ? helm_release.consul.manifest.values.service.loadBalancerIP : null
}


/**
 * Vault service URL
*/
output "vault_service_url" {
  value = "http://${kubernetes_service.vault_service.load_balancer_ingress[0].hostname}:8080"
}


/**
 * Consul release name
*/ 
output "consul_release_name" {
  value = helm_release.consul.name
}


/**
 * Vault release name
*/
output "vault_release_name" {
  value = helm_release.vault.name
}
