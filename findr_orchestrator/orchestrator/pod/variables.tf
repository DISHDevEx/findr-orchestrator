variable "aws_region" {
  description = "AWS region name"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS account - credentials profile name"
  type        = string
  default     = null
  sensitive   = true
}

variable "cluster_name" {
  type    = string
  default = ""
}

variable "vault_secret_path" {
  type    = string
  default = ""
}

variable "harbor_image" {
  type    = string
  default = ""
}
