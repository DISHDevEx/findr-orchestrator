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

# Kubernetes Deployment
resource "kubernetes_deployment" "ui_deployment" {
  metadata {
    name      = "ui"
    namespace = var.ui_namespace
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
          image = "docker.io/pravnreddy429/findr_ui"  # Specify your Docker Hub image
        }
      }
    }
  }
}

# Kubernetes Service of type LoadBalancer
resource "kubernetes_service" "ui_service" {
  metadata {
    name      = "ui-service"
    namespace = var.ui_namespace
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
