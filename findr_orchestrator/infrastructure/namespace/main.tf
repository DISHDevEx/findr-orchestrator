# Kubernetes Provider Configuration
# Sets up the Kubernetes provider using the configuration file located at '~/.kube/config'.
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Kubernetes Namespace Resource: Orchestrator
# Creates a Kubernetes namespace for the orchestrator, with the name sourced from a variable.
resource "kubernetes_namespace" "orchestrator" {
  metadata {
    name = var.namespace_1
  }
}

# Kubernetes Namespace Resource: Monitoring
# Creates a Kubernetes namespace for monitoring purposes, with the name sourced from a variable.
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.namespace_2
  }
}

# Kubernetes Namespace Resource: Vault
# Creates a Kubernetes namespace for Vault, with the name sourced from a variable.
resource "kubernetes_namespace" "vault" {
  metadata {
    name = var.namespace_3
  }
}

# Kubernetes Namespace Resource: Harbor
# Creates a Kubernetes namespace for Harbor, with the name sourced from a variable.
resource "kubernetes_namespace" "harbor" {
  metadata {
    name = var.namespace_4
  }  
}

# Kubernetes Namespace Resource: UI
# Creates a Kubernetes namespace for UI, with the name sourced from a variable.
resource "kubernetes_namespace" "UI" {
  metadata {
    name = var.namespace_5
  }  
}

# Kubernetes Namespace Resource: oracle
# Creates a Kubernetes namespace for oracle, with the name sourced from a variable.
resource "kubernetes_namespace" "oracle" {
  metadata {
    name = var.namespace_6
  }  
}

# Kubernetes Namespace Resource: apollo
# Creates a Kubernetes namespace for apollo, with the name sourced from a variable.
resource "kubernetes_namespace" "apollo" {
  metadata {
    name = var.namespace_7
  }  
}
