variable "cluster_name" {
  type    = string
  default = ""
}

variable "harbor_password" {
  type    = string
  default = ""
  sensitive  = true
}
