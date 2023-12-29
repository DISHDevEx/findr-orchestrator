provider "aws" {
  region = var.aws_region
}

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
    args        = ["eks", "get-token", "--region", var.aws_region, "--cluster-name", var.cluster_name]
  }
}

# ServiceAccount
resource "kubernetes_service_account" "findr_service_account" {
  metadata {
    name      = "findr-service-account"
    namespace = var.namespace
  }
}

# Role
resource "kubernetes_role" "findr_role" {
  metadata {
    name      = "findr-role"
    namespace = var.namespace
  }

  rule {
    api_groups = [""]
    resources  = ["secrets", "services"]
    verbs      = ["create", "get", "list", "watch", "delete", "update"]
  }
}

# RoleBinding
resource "kubernetes_role_binding" "findr_role_binding" {
  metadata {
    name      = "findr-role-binding"
    namespace = var.namespace
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.findr_service_account.metadata[0].name
    namespace = var.namespace
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.findr_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}
