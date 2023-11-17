# Define a Kubernetes Pod resource
resource "kubernetes_pod" "findr_pod" {
  metadata {
    name = var.pod_name
    labels = {
      app = var.app
    }
  }

  spec {
    container {
      image = var.container_image
      name  = var.container_name

      # Optional: Define ports, environment variables, etc.
    }

    # Optionally: Define additional containers, init containers, volumes, etc.
  }
}
