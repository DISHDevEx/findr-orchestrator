/**
 * Kubernetes provider configuration.
 */
provider "kubernetes" {
  host                   = var.k8s_cluster_endpoint
  client_certificate     = file(var.client_certificate_path)
  client_key             = file(var.client_key_path)
  cluster_ca_certificate = file(var.cluster_ca_certificate_path)
}

/**
 * Kubernetes pod resource definition.
 */
resource "kubernetes_pod" "example" {
  metadata {
    name = "example-pod"
    labels = {
      app = "example"
    }
  }

  spec {
    container {
      image = var.container_image
      name  = "example-container"
    }
  }
}
