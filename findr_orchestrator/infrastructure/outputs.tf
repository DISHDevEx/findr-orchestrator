
#eks_cluster - module output
output "findr_orchestrator_details" {
  description = "Cluster details"
  value      = module.findr-orchestrator[*]
}

output "findr_edge_details" {
  description = "Cluster details"
  value      = module.findr-edge[*]
}

# Output for Namespace Module
# This assumes your namespace module outputs something like the namespace name or ID
output "findr_namespaces" {
  value       = module.namespace[*]
  description = "The names of created Kubernetes namespace."
}

# # Output for Monitoring Module
# # Assuming your Monitoring module outputs relevant details like Vault URL or status
# output "findr_monitoring" {
#   value       = module.monitoring[*]
#   description = "The URL for the deployed Vault instance."
# }

# Output for Vault Module
# Assuming your Vault module outputs relevant details like Vault URL or status
output "findr_vault" {
  value       = module.vault[*]
  description = "The URL for the deployed Vault instance."
  sensitive = true
}

# Output for Harbor Module
# Assuming your Harbor module outputs details like Harbor URL or status
output "findr_harbor" {
  value       = module.harbor[*]
  description = "The URL for the deployed Harbor instance."
  sensitive = true
}
