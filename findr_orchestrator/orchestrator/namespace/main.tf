# Define a Kubernetes namespace resource
resource "kubernetes_namespace" "findr_namespace" {
  metadata {
    name = var.namespace_name
  }
}
