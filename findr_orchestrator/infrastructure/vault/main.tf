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


resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  namespace  = "vault"

  set {
    name  = "server.ha.enabled"
    value = "true"
  }

  # set {
  #   name  = "server.ha.replicaCount"
  #   value = "3"
  # }

  set {
    name  = "global.tlsDisable"
    value = "false"
  }

  # set {
  #   name  = "server.storage.consul.address"
  #   value = "consul-consul-server:8500"
  # }

  # set {
  #   name  = "injector.enabled"
  #   value = "true"
  # }

  set {
    name  = "server.resources.limits.cpu"
    value = "500m"
  }
  set {
    name  = "server.resources.limits.memory"
    value = "512Mi"
  }

  # set {
  #   name  = "secrets.autoUnseal.awsKms.region"
  #   value = "us-west-2"
  # }

  # set {
  #   name  = "secrets.autoUnseal.awsKms.keyId"
  #   value = "your-aws-kms-key-id"
  # }
}
