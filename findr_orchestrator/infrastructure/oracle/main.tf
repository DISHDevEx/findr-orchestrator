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
resource "kubernetes_deployment" "oracle_deployment" {
  metadata {
    name      = "oracle"
    namespace = var.oracle_namespace
  }

  spec {
    replicas = 3

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
          image = "docker.io/pravnreddy429/findr_oracle:v1"  # Specify your Docker Hub image
        }
      }
    }
  }
}

# Kubernetes Service of type LoadBalancer
resource "kubernetes_service" "oracle_service" {
  metadata {
    name      = "oracle-service"
    namespace = var.oracle_namespace
  }

  spec {
    selector = {
      app = "oracle"
    }

    port {
      protocol   = "TCP"
      port       = 6000
      target_port = 6000
    }

    type = "LoadBalancer"
  }
}
