data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}


provider "helm" {
  experiments {
    manifest = true
  }
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}


resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  namespace  = "vault"

  set {
    name  = "server.dev.enabled"
    value = "true"
  }

  set {
    name  = "global.tlsDisable"
    value = "false"
  }

  # set {
  #   name  = "server.ha.replicaCount"
  #   value = "2"
  # }

  # set {
  #   name  = "server.resources.limits.cpu"
  #   value = "500m"
  # }

  # set {
  #   name  = "server.resources.limits.memory"
  #   value = "512Mi"
  # }

  # set {
  # name  = "server.service.type"
  # value = "ClusterIP"
  # }

  # set {
  #   name  = "server.storage.consul.address"
  #   value = "consul-consul-server:8500"
  # }

  # set {
  #   name  = "injector.enabled"
  #   value = "true"
  # }

  # set {
  #   name  = "secrets.autoUnseal.awsKms.region"
  #   value = "us-west-2"
  # }

  # set {
  #   name  = "secrets.autoUnseal.awsKms.keyId"
  #   value = "your-aws-kms-key-id"
  # }
}

resource "kubernetes_service" "vault_service" {
  metadata {
    name = "vault-service"
    labels = {
      app = "vault"
    }
  }

  spec {
    selector = {
      app = "helm_release.vault.metadata.0.name"
    }
    port {
      port        = 8080       # Vault HTTP port
      target_port = 8080
    }

    type = "ClusterIP"  # Or NodePort, LoadBalancer as per your requirement
  }
}
