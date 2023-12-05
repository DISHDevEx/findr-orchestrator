provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "orchestrator" {
  metadata {
    name = var.namespace_1
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.namespace_2
  }
}

resource "kubernetes_namespace" "vault" {
  metadata {
    name = var.namespace_3
  }
}

resource "kubernetes_namespace" "harbor" {
  metadata {
    name = var.namespace_4
  }
  
}
