output "eks_cluster_endpoint" {
  value       = data.aws_eks_cluster.cluster.endpoint
  description = "The endpoint for the EKS cluster."
}

output "orchestrator_namespace" {
  value       = kubernetes_namespace.orchestrator.metadata[0].name
  description = "The name of the Orchestrator Kubernetes namespace."
}

output "monitoring_namespace" {
  value       = kubernetes_namespace.monitoring.metadata[0].name
  description = "The name of the Monitoring Kubernetes namespace."
}

output "vault_namespace" {
  value       = kubernetes_namespace.vault.metadata[0].name
  description = "The name of the Vault Kubernetes namespace."
}

output "harbor_namespace" {
  value       = kubernetes_namespace.harbor.metadata[0].name
  description = "The name of the Harbor Kubernetes namespace."
}
