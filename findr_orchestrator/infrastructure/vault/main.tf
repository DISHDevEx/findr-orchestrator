provider "kubernetes" {
  # Configuration for the Kubernetes provider
  config_path = "~/.kube/config"
}

provider "helm" {
  experiments {
    manifest = true
  }
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "consul" {
  name       = "consul"
  namespace  = var.vault_namespace
  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"
  ## version    = "0.34.1"

  set {
    name  = "global.name"
    value = "consul"
  }

  # Additional configurations can be added here
}

resource "helm_release" "vault" {
  name       = "vault"
  namespace  = var.vault_namespace
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  ## version    = "0.13.0"

  set {
    name  = "server.dev.enabled"
    value = "true"
  }

  # Additional configurations can be added here
}

resource "kubernetes_service" "vault_service" {
  metadata {
    name = "vault-service"
    labels = {
      app = "vault"
    }
  }

  spec {
    selector = {
      app = "helm_release.vault.metadata.0.name"
    }
    port {
      port        = 8080       # Vault HTTP port
      target_port = 8080
    }

    type = "ClusterIP"  # Or NodePort, LoadBalancer as per your requirement
  }
}
