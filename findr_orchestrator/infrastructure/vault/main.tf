/**
 * Configure Helm provider for deploying Helm charts in Kubernetes.
 * This provider setup uses a kubeconfig file located at "~/.kube/config".
 */
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

/**
 * Deploy Vault using the Helm chart from HashiCorp.
 * 
 * This deployment sets up Vault in a high availability configuration with Raft storage backend.
 * It also enables the Vault UI and exposes it using a LoadBalancer service.
 * 
 * Variables:
 * - `server.ha.enabled`: Enables high availability mode.
 * - `server.ha.raft.enabled`: Enables Raft integrated storage used in HA mode.
 * - `server.ui.enabled`: Enables the Vault web UI.
 * - `server.service.type`: Configures the service type, set to LoadBalancer to expose Vault externally.
 */
resource "helm_release" "vault" {
  # Uncomment the line below if Vault depends on a Consul deployment.
  # depends_on = [helm_release.consul]

  name       = "vault"             // Name of the Helm release
  namespace  = var.vault_namespace // Kubernetes namespace to deploy Vault in
  repository = "https://helm.releases.hashicorp.com" // Helm chart repository URL
  chart      = "vault"             // Name of the Helm chart

  set {
    name  = "server.ha.enabled"
    value = "true" // Enable HA mode
  }

  set {
    name  = "server.ha.raft.enabled"
    value = "true" // Enable Raft storage backend for HA
  }

  set {
    name  = "server.ui.enabled"
    value = "true" // Enable Vault UI
  }

  set {
    name  = "server.service.type"
    value = "LoadBalancer" // Expose Vault using a LoadBalancer service
  }
}
