# Define Variables
# ----------------
variable "cluster_config" {
  description = "The path to the kubeconfig file."
  type        = string
}

variable "pod_name" {
  description = "The name of the Kubernetes pod."
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

variable "pod_port" {
  description = "The portfor the pod."
  type        = string
}

variable "loadbalancer" {
  description = "The loadbalancer for the pod."
  type        = string
}