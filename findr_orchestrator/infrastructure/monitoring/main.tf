provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 1.9"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = "findr-orchestrator-test"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args        = ["eks", "get-token", "--region", "us-east-1", "--cluster-name", "findr-orchestrator-test"]
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

data "http" "thanos_storage_config" {
  url = "https://github.com/DISHDevEx/napp/blob/main/napp/monitoring/prometheus/thanos-storage-config.yaml"
}

resource "kubernetes_secret" "thanos_objstore_config" {
  metadata {
    name      = "thanos-objstore-config"
    namespace = "findr-orchestrator-test-namespace"
  }

  data = {
    "thanos.yaml" = data.http.thanos_storage_config.body
  }
}

data "http" "custom_prom_cm" {
  url = "https://github.com/DISHDevEx/napp/blob/main/napp/monitoring/prometheus/custom-prom-cm.yaml"
}

resource "helm_release" "kube_prometheus" {
  name      = "kube-prometheus"
  repository = "https://charts.bitnami.com/bitnami"
  chart     = "kube-prometheus"
  namespace = "findr-orchestrator-test-namespace"

  values = [
    data.http.custom_prom_cm.body,
  ]
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
  namespace = "findr-orchestrator-test-namespace"

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
    namespace = "findr-orchestrator-test-namespace"
  }

  data = {
    "cluster.name"    = "findr-orchestrator-test"
    "loki.host"       = "$(kubectl get pod loki-stack-0 --template '{{.status.podIP}}')"
    "http.server"     = "On"
    "http.port"       = "2020"
    "read.head"       = "Off"
    "read.tail"       = "On"
    "logs.region"     = "us-east-1"
  }
}

output "module_path" {
  value = path.module
}
