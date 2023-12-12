# main.tf

provider "kubernetes" {
  config_path = var.cluster_config
}

data "kubernetes_namespace" "findr_existing_namespace" {
  metadata {
    name = var.namespace
  }
  depends_on = [provider.kubernetes]
}

locals {
  namespace_exists = data.kubernetes_namespace.existing.metadata.0.name == var.namespace
}

resource "kubernetes_namespace" "findr_new_namespace" {
  count = local.namespace_exists ? 0 : 1
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_pod" "findr_pod" {
  metadata {
    name      = var.pod_name
    namespace = var.namespace
    labels = {
      app = var.pod_name
    }
  }

  spec {
    container {
      image = var.container_image
      name  = var.pod_name
    }
  }
}
