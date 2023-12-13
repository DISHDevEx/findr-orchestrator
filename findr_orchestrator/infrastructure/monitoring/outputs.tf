# outputs.tf

/**
 * The endpoint of the EKS cluster
*/
output "eks_cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}


/**
 * The name of the EKS cluster
*/ 
output "cluster_name" {
  value = var.cluster_name
}


/**
 * URL to access Grafana dashboard
*/
output "grafana_url" {
  description = "Instruction to find the external IP address of Grafana's LoadBalancer"
  value       = "Use 'kubectl get svc -n monitoring -o wide' to find the external IP address of Grafana's LoadBalancer service."
}


/**
 * Path to Terraform modules directory
*/
output "module_path" {
  value = path.module
}