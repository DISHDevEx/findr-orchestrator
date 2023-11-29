data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

resource "helm_release" "harbor" {
  name       = "harbor"
  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  namespace  = "harbor"  # Adjust as needed
  version    = "1.7.0"

  set {
    name  = "expose.type"
    value = "ClusterIP"  # Or NodePort, LoadBalancer as per your requirement
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "harborAdminPassword"
    value = var.harbor_password  # Replace with a strong password
  }

  # Additional Harbor configurations...
}

resource "kubernetes_service" "harbor_service" {
  metadata {
    name = "harbor-service"
    labels = {
      app = "harbor"
    }
  }

  spec {
    selector = {
      app = "helm_release.harbor.metadata.0.name"
    }
    port {
      port        = 80       # Harbor HTTP port
      target_port = 80
    }

    type = "ClusterIP"  # Or NodePort, LoadBalancer as per your requirement
  }
}
