variable "k8s_cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  type        = string
}

variable "client_certificate_path" {
  description = "Path to the client certificate for Kubernetes authentication"
  type        = string
}

variable "client_key_path" {
  description = "Path to the client key for Kubernetes authentication"
  type        = string
}

variable "cluster_ca_certificate_path" {
  description = "Path to the cluster CA certificate"
  type        = string
}

variable "container_image" {
  description = "The container image to use in the pod"
  type        = string
  default     = "nginx"
}
