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

resource "helm_release" "namespace" {
  count      = length(var.namespaces)
  name       = "namespace-${var.namespaces[count.index]}"
  repository = "https://charts.helm.sh/stable"
  chart      = "my-namespace-chart"
  version    = "1.0.0"

  set {
    name  = "name"
    value = var.namespaces[count.index]
  }
}
