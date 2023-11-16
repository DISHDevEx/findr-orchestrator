provider "kubernetes" {
  config_path = "/Users/rizwan.bhatty/.kube/config-cluster-b.yaml"
}

resource "kubernetes_pod" "findr_pod" {
  metadata {
    name      = var.pod_name
    namespace = kubernetes_namespace.findr_namespace.metadata.0.name
  }

  spec {
    container {
      name  = "example-container"
      image = "nginx"  # Use your desired image
    }
  }
}