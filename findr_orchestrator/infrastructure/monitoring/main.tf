# AWS Provider Configuration
# Configures the AWS provider with region set to "us-east-1".
provider "aws" {
  region = "us-east-1"
}

# Terraform Configuration
# Specifies the required providers with their respective sources and versions.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

# Data Source: AWS EKS Cluster
# Retrieves data about an existing AWS EKS cluster using the cluster name variable.
data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

# Kubernetes Provider Configuration
# Configures the Kubernetes provider with the EKS cluster's endpoint and CA certificate.
# Authentication is managed via the AWS CLI for token generation.
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--region", "us-east-1", "--cluster-name", var.cluster_name]
  }
}

# Helm Provider Configuration
# Sets up the Helm provider with Kubernetes configuration path.
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Data Source: Thanos Storage Config
# Fetches the Thanos storage configuration from a specified GitHub URL.
data "http" "thanos_storage_config" {
  url = "https://github.com/DISHDevEx/napp/blob/main/napp/monitoring/prometheus/thanos-storage-config.yaml"
}

# Kubernetes Secret Resource
# Creates a Kubernetes secret for Thanos object store configuration.
resource "kubernetes_secret" "thanos_objstore_config" {
  metadata {
    name      = "thanos-objstore-config"
    namespace = var.monitoring_namespace
  }

  data = {
    "thanos.yaml" = data.http.thanos_storage_config.body
  }
}

# Data Source: Custom Prometheus ConfigMap
# Retrieves a custom Prometheus ConfigMap from a specified GitHub URL.
data "http" "custom_prom_cm" {
  url = "https://github.com/DISHDevEx/napp/blob/main/napp/monitoring/prometheus/custom-prom-cm.yaml"
}

# Helm Release Resource: Kube Prometheus
# Deploys the kube-prometheus chart from the Bitnami repository into the specified namespace.
resource "helm_release" "kube_prometheus" {
  name       = "kube-prometheus"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kube-prometheus"
  namespace  = var.monitoring_namespace

  # values = [
  #   data.http.custom_prom_cm.body,
  # ]
}

# Null Resource for EKS Script Execution
# Defines a null resource to execute a script with dependencies on various Helm releases and Kubernetes resources.
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

# Helm Release Resource: Loki Stack
# Deploys the Loki stack chart from the Grafana repository into the specified namespace.
# Configures settings for Promtail and Grafana.
resource "helm_release" "loki_stack" {
  name       = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  namespace  = var.monitoring_namespace

  set {
    name  = "promtail.enabled"
    value = "false"
  }

  set {
    name  = "grafana.enabled"
    value = "true"
  }
}

# Kubernetes ConfigMap Resource
# Creates a ConfigMap with cluster information and logging settings.
resource "kubernetes_config_map" "fluent_bit_cluster_info" {
  metadata {
    name      = "fluent-bit-cluster-info"
    namespace = var.monitoring_namespace
  }

  data = {
    "cluster.name"    = var.cluster_name
    "loki.host"       = "$(kubectl get pod loki-stack-0 --template '{{.status.podIP}}')"
    "http.server"     = "On"
    "http.port"       = "2020"
    "read.head"       = "Off"
    "read.tail"       = "On"
    "logs.region"     = "us-east-1"
  }
}