output "harbor_service_endpoint" {
    description = "Endpoint for accessing Vault"
    value = helm_release.harbor.status.load_balancer.ingress[0].ip
}
