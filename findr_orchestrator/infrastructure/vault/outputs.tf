output "eks_cluster_endpoint" {
  value       = data.aws_eks_cluster.cluster.endpoint
  description = "The endpoint for the EKS cluster."
  sensitive = true
}

output "eks_cluster_ca_certificate" {
  value       = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  description = "The cluster CA certificate for the EKS cluster."
  sensitive = true
}

output "eks_cluster_auth_token" {
  value       = data.aws_eks_cluster_auth.cluster.token
  description = "The auth token for accessing the EKS cluster."
  sensitive = true
}

output "vault_helm_release_status" {
  value       = helm_release.vault.status
  description = "The status of the Helm release for Vault."
  sensitive = true
}

output "vault_namespace" {
  value       = helm_release.vault.namespace
  description = "The Kubernetes namespace where Vault is deployed."
  sensitive = true
}

output "vault_helm_chart" {
  value       = helm_release.vault.chart
  description = "The name and version of the Vault Helm chart deployed."
  sensitive = true
}

output "vault_service_name" {
  value       = kubernetes_service.vault_service.metadata[0].name
  description = "The name of the Kubernetes service for Vault."
  sensitive = true
}

output "vault_service_http_port" {
  value       = kubernetes_service.vault_service.spec[0].port[0].port
  description = "The HTTP port for the Vault service."
  sensitive = true
}