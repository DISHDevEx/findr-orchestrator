/**
 * Configure Helm provider for deploying Helm charts
*/
provider "helm" {

  kubernetes {

    /**
     * Path to kubeconfig file for Kubernetes cluster
     */
    config_path = "~/.kube/config"

  }

}

/**
 * Install Consul chart from HashiCorp
*
* This will deploy Consul in a client-server configuration.
* See https://artifacthub.io/packages/helm/hashicorp/consul for chart documentation
*/
resource "helm_release" "consul" {

  /**
   * Release name
   */
  name = "consul"  

  /**
   * Target namespace
   */ 
  namespace = var.vault_namespace

  /**
   * HashiCorp Helm chart repository
   */
  repository = "https://helm.releases.hashicorp.com"

  /**
   * Consul Helm chart
   */
  chart = "consul"

  /** 
   * Set global name label
   *
   * This sets the `name` label on all Kubernetes objects
   */
  set {
    name = "global.name"
    value = "consul"
  }

}


/**
 * Install Vault chart from HashiCorp
*
* This will deploy Vault in a dev mode for development/testing.
* See https://artifacthub.io/packages/helm/hashicorp/vault for chart docs
*/
resource "helm_release" "vault" {

  /**
   * Release name  
   */
  name = "vault"

  /**
   * Target namespace
   */
  namespace = var.vault_namespace

  /**
   * HashiCorp Helm chart repository
   */
  repository = "https://helm.releases.hashicorp.com"

  /**
   * Vault Helm chart
   */
  chart = "vault"

  /**
   * Enable dev mode for easier unsealing
   */
  set {
    name = "server.dev.enabled"
    value = "true" 
  }

}


/**
 * Expose Vault service
*
* Creates a ClusterIP service for Vault
*/
resource "kubernetes_service" "vault_service" {

  /**
   * Service metadata
   */
  metadata {
    name = "vault-service"
    labels = {
      app = "vault"
    }
  }

  /**
   * Service spec
   */
  spec {

    /**
     * Selector to find Vault pods
     */
    selector = {
      app = helm_release.vault.metadata[0].name
    }

    /**
     * Service port
     */
    port {
      port        = 8080
      target_port = 8080
    }

    /**
     * ClusterIP service type
     */
    type = "ClusterIP"

  }

}
