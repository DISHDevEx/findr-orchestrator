output "pod_name" {
  value       = kubernetes_deployment.oracle_deployment.metadata[0].name
  description = "The name of the deployed Kubernetes pod."
  sensitive = true
}

output "load_balancer_ip" {
  description = "Instruction to find the external IP address of Pod's LoadBalancer"
  value       = "Use 'kubectl get svc -n var.namespace -o wide' to find the external IP address of Pod's LoadBalancer service."
}