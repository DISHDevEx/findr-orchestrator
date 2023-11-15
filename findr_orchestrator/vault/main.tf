resource "helm_release" "vault" {
  name       = "vault"
  chart      = "vault"
  repository = "https://helm.releases.hashicorp.com"
  namespace  = "vault"

  set {
    name  = "server.dev.enabled"
    value = "true"
  }

  # Additional settings can be added here as needed.
}
