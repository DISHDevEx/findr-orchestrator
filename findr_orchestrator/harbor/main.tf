resource "helm_release" "harbor" {
  name       = "harbor"
  chart      = "harbor"
  repository = "https://helm.goharbor.io"
  namespace  = "harbor"

  set {
    name  = "expose.type"
    value = "LoadBalancer"
  }

  set {
    name  = "expose.tls.enabled"
    value = "false"
  }

  # Additional Harbor configurations can be added here.
  # For example, you might want to set 'externalURL', 'persistence.persistentVolumeClaim', etc.
}
