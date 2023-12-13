# Data Source: AWS EKS Cluster
# Retrieves data about an existing AWS EKS cluster using the cluster name variable.
data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

# Kubernetes Provider Configuration
# Configures the Kubernetes provider with the EKS cluster's endpoint and CA certificate.
# Authentication is managed via the AWS CLI for token generation.
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--region", "us-east-1", "--cluster-name", var.cluster_name]
  }
}

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
    value = "false" // Enable HA mode
  }

  set {
    name  = "server.ha.raft.enabled"
    value = "true" // Enable Raft storage backend for HA
  }

  set {
    name  = "ui.enabled"
    value = "true" // Enable Vault UI
  }

  set {
    name  = "ui.serviceType"
    value = "LoadBalancer"
  }

  set {
    name  = "ui.servicePort"
    value = "8200"
  }

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set {
    name  = "server.ingress.hosts[0].host"
    value = "vault-findr.com"
  }
  
  set {
    name  = "server.ingress.ingressClassName"
    value = "nginx"
  }

  set {
    name  = "server.route.enabled"
    value = "true"
  }

}