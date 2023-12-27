variable "eks_cluster_region" {
  description = "The region of your EKS cluster"
  type        = string
  default     = "us-east-1"
}

variable "namespace" {
  description = "The Kubernetes namespace where resources are deployed"
  type        = string
  default     = "default"
}

variable "nginx_image" {
  description = "Docker image for nginx1 pod"
  type        = string
  default     = "docker.io/library/nginx"
}

variable "nginx_container_port" {
  description = "Port for nginx container"
  type        = number
  default     = 80
}

variable "nginx_service_port" {
  description = "Port for nginx service"
  type        = number
  default     = 80
}
