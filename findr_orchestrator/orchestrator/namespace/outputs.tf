#Namespace - module output
output "helm_release_names" {
  description = "The names of the deployed Helm releases for namespaces"
  value       = [for release in helm_release.namespace : release.name]
}

output "helm_release_namespaces" {
  description = "The namespaces of the deployed Helm releases"
  value       = [for release in helm_release.namespace : release.namespace]
}

output "helm_release_status" {
  description = "The status of the deployed Helm releases"
  value       = {for idx, release in helm_release.namespace : release.name => release.status}
}