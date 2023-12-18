# Kubernetes Provider Configuration
# ---------------------------------
provider "kubernetes" {
  # Configures the Kubernetes provider with the path to the kubeconfig file.
  config_path = var.cluster_config
}

# Kubernetes Pod Resource
# -----------------------
resource "kubernetes_pod" "findr_pod" {
  metadata {
    name      = var.pod_name
    namespace = var.namespace
  }

  spec {
    container {
      image = var.container_image
      name  = var.pod_name
    }
  }
}

# Kubernetes Load Balancer Service
# --------------------------------
resource "kubernetes_service" "findr_lb" {
  metadata {
    name = var.loadbalancer
    namespace = var.namespace
  }
  spec {
    selector = {
      app = var.pod_name
    }
    port {
      port        = var.pod_port
      target_port = var.pod_port
    }
    type = "LoadBalancer"
  }
}