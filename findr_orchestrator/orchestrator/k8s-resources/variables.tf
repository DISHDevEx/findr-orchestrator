# variables.tf

variable "pod_name" {
  description = "Name of the Kubernetes pod"
  type        = string

}

variable "container_image" {
  description = "Container image to use in the pod"
  type        = string
}

variable "cluster_config" {
  description = "Kubernetes cluster configuration"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "findr"
}
