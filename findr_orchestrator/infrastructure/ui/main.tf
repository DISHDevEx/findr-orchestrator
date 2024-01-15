# main.tf

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

#Get NodePort and NodeIP of Oracle for API endpoint
resource "null_resource" "export_oracle" {
  triggers = {
    # Trigger when the service or any relevant configuration changes
    service_version = kubernetes_service.oracle-service.metadata[0].resource_version
  }

  provisioner "local-exec" {
    command = <<-EOT
    #get nodeport
      NODEPORT=\$(kubectl get service oracle-service -o=jsonpath='{.spec.ports[0].nodePort}')
      export ORACLE_NODE_PORT
    #get node
      POD_NAME=$(kubectl get pod -n oracle -l app=oracle -o jsonpath='{.items[0].metadata.name}')
      NODE_NAME=$(kubectl get pod $POD_NAME -n oracle -o jsonpath='{.spec.nodeName}')
      NODE_IP=$(kubectl get node $NODE_NAME -o jsonpath='{.status.addresses[?(@.type=="ExternalIP")].address}')
      export ORACLE_NODE_IP
    EOT
  }
}



# Kubernetes Deployment
resource "kubernetes_deployment" "ui_deployment" {
  metadata {
    name      = "ui"
    namespace = var.ui_namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ui"
      }
    }

    template {
      metadata {
        labels = {
          app = "ui"
        }
      }
    
      spec {
        container {
          name  = "ui-container"
          image = "docker.io/pravnreddy429/findr_ui"  # Specify your Docker Hub image
          env {
            name  = "REACT_APP_ORACLE_NODE_PORT"
            value = "${null_resource.export_oracle.ORACLE_NODE_PORT}"
          }
          env {
            name  = "REACT_APP_ORACLE_NODE_IP"
            value = "${null_resource.export_oracle.ORACLE_NODE_IP}"
          }
        }
      }
    }
  }
}

# Kubernetes Service of type LoadBalancer
resource "kubernetes_service" "ui_service" {
  metadata {
    name      = "ui-service"
    namespace = var.ui_namespace
  }

  spec {
    selector = {
      app = "ui"
    }

    port {
      protocol   = "TCP"
      port       = 7001
      target_port = 7001
    }

    type = "LoadBalancer"
  }
}
