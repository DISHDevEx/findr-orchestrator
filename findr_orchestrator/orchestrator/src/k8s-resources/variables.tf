# Define Variables
# ----------------
variable "cluster_config" {
  description = "The path to the kubeconfig file."
  type        = string
}

variable "cluster_name" {
  description = "The Cluster Name"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace in which the pod will be deployed."
  type        = string
}

variable "container_image" {
  description = "The container image to use for the pod."
  type        = string
}

variable "vault_address" {
  description = "Vault base URL"
  type        = string
}

variable "vault_token" {
  description = "Vault auth token"
  type        = string
}

variable "connection_info" {
  description = "Connection details for device"
  type        = string
}

