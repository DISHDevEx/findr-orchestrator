output "module_path" {
  value = path.module
}

output "eks_cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "thanos_storage_config_url" {
  value = data.http.thanos_storage_config.url
}

output "custom_prom_cm_url" {
  value = data.http.custom_prom_cm.url
}

output "loki_stack_chart_version" {
  value = helm_release.loki_stack.metadata[0].chart[0].version
}

output "kube_prometheus_chart_version" {
  value = helm_release.kube_prometheus.metadata[0].chart[0].version
}
