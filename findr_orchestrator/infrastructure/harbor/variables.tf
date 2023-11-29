variable "cluster_name" {
  type    = string
  default = "iot-findr-orchestrator"
}

variable "harbor_password" {
  type    = string
  default = "admin"
  sensitive  = true
}