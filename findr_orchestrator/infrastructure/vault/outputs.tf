output "eks_cluster_endpoint" {
  value       = data.aws_eks_cluster.cluster.endpoint
  description = "The endpoint for the EKS cluster."
}

output "eks_cluster_ca_certificate" {
  value       = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  description = "The cluster CA certificate for the EKS cluster."
}

output "eks_cluster_auth_token" {
  value       = data.aws_eks_cluster_auth.cluster.token
  description = "The auth token for accessing the EKS cluster."
}

output "vault_helm_release_status" {
  value       = helm_release.vault.status
  description = "The status of the Helm release for Vault."
}

output "vault_namespace" {
  value       = helm_release.vault.namespace
  description = "The Kubernetes namespace where Vault is deployed."
}

output "vault_helm_chart" {
  value       = helm_release.vault.chart
  description = "The name and version of the Vault Helm chart deployed."
}
