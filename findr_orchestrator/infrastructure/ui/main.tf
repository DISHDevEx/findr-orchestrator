# main.tf

provider "aws" {
  region = var.aws_region
}

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
    args        = ["eks", "get-token", "--region", var.aws_region, "--cluster-name", var.cluster_name]
  }
}

# Kubernetes ConfigMap
resource "kubernetes_config_map" "env_config" {
  metadata {
    name      = "env-config"
    namespace = var.namespace
  }

  data = {
    FINDR_ORACLE_URL = var.findr_oracle_url
  }
}

# Kubernetes Deployment
resource "kubernetes_deployment" "ui_deployment" {
  metadata {
    name      = "ui"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ui"
      }
    }

    template {
      metadata {
        labels = {
          app = "ui"
        }
      }

      spec {
        container {
          name  = "ui-container"
          image = var.ui_image

          # Set the environment variables in the container
          env {
            name  = "FINDR_ORACLE_URL"
            value = ""
          }
        }

        # Mount the ConfigMap as a volume
        volume {
          name = "env-config-volume"
          config_map {
            name = kubernetes_config_map.env_config.metadata[0].name
          }
        }
      }
    }
  }
}

# Kubernetes Service of type LoadBalancer
resource "kubernetes_service" "ui_service" {
  metadata {
    name      = "ui-service"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "ui"
    }

    port {
      protocol   = "TCP"
      port       = 7000
      target_port = 7000
    }

    type = "LoadBalancer"
  }
}