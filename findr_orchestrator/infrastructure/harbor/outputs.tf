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

output "harbor_namespace" {
  value       = helm_release.harbor.namespace
  description = "The Kubernetes namespace where Vault is deployed."
}

output "harbor_helm_release_status" {
  value       = helm_release.harbor.status
  description = "The status of the Helm release for Harbor."
}

output "harbor_service_name" {
  value       = kubernetes_service.harbor_service.metadata[0].name
  description = "The name of the Kubernetes service for Harbor."
}

output "harbor_service_http_port" {
  value       = kubernetes_service.harbor_service.spec[0].port[0].port
  description = "The HTTP port for the Harbor service."
}