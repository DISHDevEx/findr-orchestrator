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
 * Deploy Harbor Helm chart
*/
resource "helm_release" "harbor" {

  /**
   * Basic info about Harbor release
   */
  name       = "harbor"
  chart      = "harbor"
  repository = "https://helm.goharbor.io"

  

  /**
   * Namespace and configuration values
   */
  namespace = var.harbor_namespace

  set {
    name  = "expose.type"
    value = "nodePort"
  }

  set {  
    name  = "persistence.enabled"
    value = true
  }

  set {
    name  = "harborAdminPassword"
    value = var.harbor_password
  }

  set {
    name  = "expose.tls.enabled"
    value = true 
  }

  set {
    name  = "expose.tls.secretName"
    value = "harbor-tls"
  }

  set {
    name = "expose.tls.auto.commonName"
    value = var.tls_auto_common_name
  }

}
