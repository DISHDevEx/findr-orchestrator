#eks_cluster - module output
output "eks_cluster_outputs" {
  description = "EKS cluster arn"
  value       = [module.findr-utilities[*], module.findr-orchestrator[*], module.findr-edge[*]]
}