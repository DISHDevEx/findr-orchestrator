variable "eks_cluster_region" {
  description = "The region of your EKS cluster"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of your EKS cluster"
  type        = string
  default     = "iot-findr"
}

variable "namespace" {
  description = "The Kubernetes namespace where resources are deployed"
  type        = string
  default     = "oracle"
}

variable "container_image" {
  description = "Docker image for oracle pod"
  type        = string
  default     = "docker.io/pravnreddy429/findr_oracle:v4"
}

variable "container_port" {
  description = "Port for oracle container"
  type        = number
  default     = 6000
}