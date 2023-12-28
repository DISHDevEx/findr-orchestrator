provider "aws" {
  region = var.eks_cluster_region
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--region", var.eks_cluster_region, "--cluster-name", var.cluster_name]
  }
}

resource "kubernetes_pod" "oracle_pod" {
  metadata {
    name      = "oracle-pod"
    namespace = var.namespace
  }

  spec {
    container {
      image = var.container_image
      name  = "oracle"
      port {
        container_port = var.container_port
      }
    }
  }
}

resource "kubernetes_service" "oracle_lb" {
  metadata {
    name      = "oracle-lb"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "oracle"
    }

    port {
      port        = var.container_port
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}
