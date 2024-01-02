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
    FINDR_ORCHESTRATOR_URL = var.findr_orchestrator_url
    VAULT_URL              = var.vault_url
    VAULT_TOKEN            = var.vault_token
  }
}

# Kubernetes Deployment
resource "kubernetes_deployment" "oracle_deployment" {
  metadata {
    name      = "oracle"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "oracle"
      }
    }

    template {
      metadata {
        labels = {
          app = "oracle"
        }
      }

      spec {
        container {
          name  = "oracle-container"
          image = var.oracle_image

          # Set the environment variables in the container
          env {
            name  = "FINDR_ORCHESTRATOR_URL"
            value = ""
          }

          env {
            name  = "VAULT_URL"
            value = var.vault_url
          }

          env {
            name  = "VAULT_TOKEN"
            value = var.vault_token
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
resource "kubernetes_service" "oracle_service" {
  metadata {
    name      = "oracle-service"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "oracle"
    }

    port {
      protocol   = "TCP"
      port       = 9000
      target_port = 9000
    }

    type = "LoadBalancer"
  }
}