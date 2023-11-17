provider "kubernetes" {
  config_path = "/Users/rizwan.bhatty/.kube/config-cluster-b.yaml"
}

resource "kubernetes_namespace" "findr_namespace" {
  metadata {
    name = var.namespace_name
  }
}
