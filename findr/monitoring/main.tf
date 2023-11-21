provider "aws" {
  region = "your_eks_cluster_region"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Update this with your kubeconfig path
  }
}

resource "null_resource" "eks_script_execution" {
  depends_on = [
    helm_release.loki_stack,
    kubernetes_config_map.fluent_bit_cluster_info,
    helm_release.kube_prometheus,
    kubernetes_secret.thanos_objstore_config
  ]

  triggers = {
    script_content = <<-EOT
      #!/bin/bash

      # Rest of your script content here
    EOT
  }

  provisioner "local-exec" {
    command = <<-EOT
      ${null_resource.eks_script_execution.triggers.script_content}
    EOT
  }
}

resource "helm_release" "loki_stack" {
  name      = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  chart     = "loki-stack"
  namespace = "default"

  set {
    name  = "promtail.enabled"
    value = "false"
  }

  set {
    name  = "grafana.enabled"
    value = "true"
  }
}

resource "kubernetes_config_map" "fluent_bit_cluster_info" {
  metadata {
    name      = "fluent-bit-cluster-info"
    namespace = "default"
  }

  data = {
    cluster.name    = "your_cluster_name"
    loki.host       = "your_loki_host"
    http.server     = "On"
    http.port       = "2020"
    read.head       = "Off"
    read.tail       = "On"
    logs.region     = "your_region_name"
  }
}

resource "kubernetes_secret" "thanos_objstore_config" {
  metadata {
    name      = "thanos-objstore-config"
    namespace = "default"
  }

  data = {
    thanos.yaml = file("path/to/thanos-storage-config.yaml")
  }
}

resource "helm_release" "kube_prometheus" {
  name      = "kube-prometheus"
  repository = "https://charts.bitnami.com/bitnami"
  chart     = "kube-prometheus"
  namespace = "default"

  values = [
    "path/to/custom-prom-cm.yaml",
  ]
}

# Add additional Terraform resources as needed for your deployment
# ...
