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

# Create a Kubernetes Secret for the .env file
resource "kubernetes_secret" "env_secret" {
  metadata {
    name = "env-secret"
    namespace = var.namespace
  }

  data = {
    ".env" = <<-EOT
      VAULT_ADDRESS= var.vault_address
      VAULT_TOKEN= var.vault_token
    EOT
  }
}

# Kubernetes Pod Resource
resource "kubernetes_pod" "orchestrator_pod" {
  metadata {
    name      = "orchestrator"
    namespace = var.namespace
  }

  spec {
    container {
      image = var.container_image
      name  = "orchestrator"

      volume_mount {
        mount_path = "app/.env"
        name       = "env-volume"
        sub_path   = ".env"
        read_only  = true
      }
    }

    volume {
      name = "env-volume"

      secret {
        secret_name = kubernetes_secret.env_secret.metadata[0].name
      }
    }
  }
}

# Kubernetes Load Balancer Service
resource "kubernetes_service" "orchestrator_lb" {
  metadata {
    name      = "orchestrator"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "orchestrator"
    }
    port {
      protocol    = "TCP"
      port        = 5000
      target_port = 5000
    }
    type = "LoadBalancer"
  }
}