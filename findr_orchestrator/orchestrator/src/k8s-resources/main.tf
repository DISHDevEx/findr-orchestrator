# Terraform Providers Configuration
terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.23.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.24.0"

    }
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = var.cluster_region
}

# Vault Provider
provider "vault" {
  address         = var.vault_address
  token           = var.vault_token
  skip_tls_verify = true
}

# Read Kubernetes Cluster Configuration from Vault
data "vault_generic_secret" "cluster_config" {
  path = var.cluster_config
}

# Kubernetes Provider Configuration
provider "kubernetes" {
  host                   = data.vault_generic_secret.cluster_config.data["host"]
  cluster_ca_certificate = base64decode(data.vault_generic_secret.cluster_config.data["certificate-authority-data"])
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--region", var.cluster_region, "--cluster-name", var.cluster_name]
  }
}

# Read Secrets from Vault
data "vault_generic_secret" "findr_secrets" {
  path = var.connection_info
}

# Create a Kubernetes Secret for the .env file
resource "kubernetes_secret" "env_secret" {
  metadata {
    name = "env-secret"
    namespace = var.namespace
  }

  data = {
    ".env" = <<-EOT
      CA_FILE_PATH=${data.vault_generic_secret.findr_secrets.data["caFilePath"]}
      CLIENT_ID=${data.vault_generic_secret.findr_secrets.data["clientId"]}
      CONTAINER_PORT=${data.vault_generic_secret.findr_secrets.data["containerPort"]}
      DESTINATION=${data.vault_generic_secret.findr_secrets.data["destination"]}
      DEVICE_ID=${data.vault_generic_secret.findr_secrets.data["deviceId"]}
      DYNAMODB_REGION=${data.vault_generic_secret.findr_secrets.data["dynamodbRegion"]}
      DYNAMODB_TABLE_NAME=${data.vault_generic_secret.findr_secrets.data["dynamodbTableName"]}
      HTTP_PORT_NUMBER=${data.vault_generic_secret.findr_secrets.data["httpPortNumber"]}
      HTTP_ROUTE=${data.vault_generic_secret.findr_secrets.data["httpRoute"]}
      LOCAL_FILE_PATH=${data.vault_generic_secret.findr_secrets.data["localFilePath"]}
      MQTTS_BROKER=${data.vault_generic_secret.findr_secrets.data["mqttsBroker"]}
      S3_BUCKET_NAME=${data.vault_generic_secret.findr_secrets.data["s3BucketName"]}
      S3_FILE_KEY=${data.vault_generic_secret.findr_secrets.data["s3FileKey"]}
      S3_REGION=${data.vault_generic_secret.findr_secrets.data["s3Region"]}
      SOURCE=${data.vault_generic_secret.findr_secrets.data["source"]}
      TOPIC=${data.vault_generic_secret.findr_secrets.data["topic"]}
      UUID=${data.vault_generic_secret.findr_secrets.data["uuid"]}
    EOT
  }
  
}

# Create a Kubernetes Secret for the CA certificate
resource "kubernetes_secret" "ca_cert_secret" {
  metadata {
    name = "ca-cert-secret"
    namespace = var.namespace
  }

  data = {
    "ca.crt" = data.vault_generic_secret.findr_secrets.data["certificate"]
  }
}

# Kubernetes Pod Resource
resource "kubernetes_pod" "findr_pod" {
  metadata {
    name      = join("-", [data.vault_generic_secret.findr_secrets.data["deviceId"], data.vault_generic_secret.findr_secrets.data["uuid"], "pod"])
    namespace = var.namespace
  }

  spec {

    service_account_name = var.service_account_name
  
    container {
      image = var.container_image
      name  = join("-", [data.vault_generic_secret.findr_secrets.data["deviceId"], data.vault_generic_secret.findr_secrets.data["uuid"], "pod"])

      volume_mount {
        mount_path = "app/.env"
        name       = "env-volume"
        sub_path   = ".env"
        read_only  = true
      }

      volume_mount {
        mount_path = "app/certs/ca.crt"
        name       = "ca-cert-volume"
        sub_path   = "ca.crt"
        read_only  = true
      }
    }

    volume {
      name = "env-volume"

      secret {
        secret_name = kubernetes_secret.env_secret.metadata[0].name
      }
    }

    volume {
      name = "ca-cert-volume"

      secret {
        secret_name = kubernetes_secret.ca_cert_secret.metadata[0].name
      }
    }
  }
}

# Kubernetes Load Balancer Service
resource "kubernetes_service" "findr_lb" {
  metadata {
    name      = join("-", [data.vault_generic_secret.findr_secrets.data["deviceId"], data.vault_generic_secret.findr_secrets.data["uuid"], "loadbalancer"])
    namespace = var.namespace
  }

  spec {
    selector = {
      app = join("-", [data.vault_generic_secret.findr_secrets.data["deviceId"], data.vault_generic_secret.findr_secrets.data["uuid"], "pod"])
    }
    port {
      port        = data.vault_generic_secret.findr_secrets.data["containerPort"]
      target_port = data.vault_generic_secret.findr_secrets.data["containerPort"]
    }
    type = "LoadBalancer"
  }
}
