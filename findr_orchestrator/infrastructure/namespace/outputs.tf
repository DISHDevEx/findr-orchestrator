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

# Output: UI Namespace
# Provides the name of the UI Kubernetes namespace.
# This output can be used in configurations that require the namespace of the UI service.
output "ui_namespace" {
  value       = kubernetes_namespace.ui.metadata[0].name
  description = "The name of the UI Kubernetes namespace."
}

# Output: oracle Namespace
# Provides the name of the oracle Kubernetes namespace.
# This output can be used in configurations that require the namespace of the oracle service.
output "oracle_namespace" {
  value       = kubernetes_namespace.oracle.metadata[0].name
  description = "The name of the Oracle Kubernetes namespace."
}

# Output: apollo Namespace
# Provides the name of the Apollo Kubernetes namespace.
# This output can be used in configurations that require the namespace of the Apollo service.
output "harbor_namespace" {
  value       = kubernetes_namespace.apollo.metadata[0].name
  description = "The name of the Apollo Kubernetes namespace."
}

