# Output Configuration for Terraform

# Output: Orchestrator Namespace
# Provides the name of the Orchestrator Kubernetes namespace.
# This is useful for referencing the namespace in other Terraform configurations or external scripts.
output "orchestrator_namespace" {
  value       = kubernetes_namespace.orchestrator.metadata[0].name
  description = "The name of the Orchestrator Kubernetes namespace."
}

# Output: Monitoring Namespace
# Provides the name of the Monitoring Kubernetes namespace.
# Essential for configurations or scripts that need to interact with the Monitoring namespace.
output "monitoring_namespace" {
  value       = kubernetes_namespace.monitoring.metadata[0].name
  description = "The name of the Monitoring Kubernetes namespace."
}

# Output: Vault Namespace
# Provides the name of the Vault Kubernetes namespace.
# Useful when configuring access or policies related to the Vault namespace.
output "vault_namespace" {
  value       = kubernetes_namespace.vault.metadata[0].name
  description = "The name of the Vault Kubernetes namespace."
}

# Output: Harbor Namespace
# Provides the name of the Harbor Kubernetes namespace.
# This output can be used in configurations that require the namespace of the Harbor service.
output "harbor_namespace" {
  value       = kubernetes_namespace.harbor.metadata[0].name
  description = "The name of the Harbor Kubernetes namespace."
}

# Uncomment the following section if you need to output the EKS cluster endpoint.
# Output: EKS Cluster Endpoint
# Provides the endpoint for the EKS cluster, useful for configurations that need to connect to the cluster.
# output "eks_cluster_endpoint" {
#   value       = data.aws_eks_cluster.cluster.endpoint
#   description = "The endpoint for the EKS cluster."
# }
