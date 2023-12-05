data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }

resource "kubernetes_namespace" "orchestrator" {
  metadata {
    name = var.namespace_1
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.namespace_2
  }
}

resource "kubernetes_namespace" "vault" {
  metadata {
    name = var.namespace_3
  }
}

resource "kubernetes_namespace" "harbor" {
  metadata {
    name = var.namespace_4
  }
  
}
