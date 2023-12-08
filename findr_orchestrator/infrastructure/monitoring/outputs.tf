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
  value = helm_release.loki_stack.manifest.values.grafana.service.type == "LoadBalancer" ? helm_release.loki_stack.manifest.values.grafana.service.loadBalancerIP : null
}


/**
 * Path to Terraform modules directory
*/
output "module_path" {
  value = path.module
}
