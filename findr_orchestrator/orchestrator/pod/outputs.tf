# Output the name of the created Pod
output "pod_name" {
  value = kubernetes_pod.example.metadata[0].name
}
