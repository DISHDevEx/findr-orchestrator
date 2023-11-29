#eks_cluster - module output
output "cluster_details" {
  description = "Cluster details"
  value      = [module.findr-orchestrator[*], module.findr-edge[*]]
}