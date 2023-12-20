provider "aws" {
  region = var.eks_cluster_region
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_pod" "nginx" {
  metadata {
    name      = "nginx"
    namespace = var.namespace
  }

  spec {
    container {
      image = var.nginx_image
      name  = "nginx"
      port {
        container_port = var.nginx_container_port
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = var.nginx_service_port
      target_port = var.nginx_container_port
    }

    type = "LoadBalancer"
  }
}
