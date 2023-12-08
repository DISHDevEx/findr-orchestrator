output "pod_name" {
  description = "The name of the deployed Kubernetes pod"
  value       = kubernetes_pod.example.metadata[0].name
}
