
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



# Fetch data from Vault (assuming Vault provider is set up)
data "vault_generic_secret" "config" {
  path = var.vault_secret_path
}

# Kubernetes ConfigMap from Vault data
resource "kubernetes_config_map" "app_config" {
  metadata {
    name = "app-config"
  }

  data = {
    "config.json" = data.vault_generic_secret.config.data_json
  }
}

# Kubernetes Deployment using image from Harbor
resource "kubernetes_deployment" "my_app" {
  metadata {
    name = "my-app"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "my-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-app"
        }
      }

      spec {
        container {
          image = var.harbor_image
          name  = "app"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.app_config.metadata[0].name
            }
          }
        }
      }
    }
  }
}

# Kubernetes Service to expose the app
resource "kubernetes_service" "my_app_service" {
  metadata {
    name = "my-app-service"
  }

  spec {
    selector = {
      app = "my-app"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 3000
    }

    type = "ClusterIP"
  }
}
