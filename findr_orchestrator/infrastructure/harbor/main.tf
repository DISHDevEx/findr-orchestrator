provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "harbor" {
  name       = "harbor"
  namespace  = var.harbor_namespace
  repository = "https://helm.goharbor.io"
  chart      = "harbor"

  set {
    name  = "expose.type"
    value = "NodeIP"
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "harborAdminPassword"
    value = var.harbor_password
  }

  set {
    name  = "expose.tls.auto.commonName"
    value = var.tls_auto_common_name
  }
}
