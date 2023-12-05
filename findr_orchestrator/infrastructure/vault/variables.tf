variable "vault_namespace" {
  description = "The Kubernetes namespace where Harbor is deployed"
  type        = string
  default     = "vault"
}
