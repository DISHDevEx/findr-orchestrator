variable "harbor_namespace" {
  description = "The Kubernetes namespace where Harbor is deployed"
  type        = string
  default     = "harbor"
}

variable "harbor_password" {
  description = "Password for harbor"
  type        = string
  default     = "harbor"
}

variable "tls_auto_common_name" {
  description = "tls auto common name"
  type        = string
  default     = "findr.harbor"
} 