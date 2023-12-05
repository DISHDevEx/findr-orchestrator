#Namespace variables
variable "cluster_name" {
  type    = string
  default = "iot-findr-orchestrator"
}

variable "namespace_1" {
  type = string
  default = "orchestrator"
}

variable "namespace_2" {
  type = string
  default = "monitoring"
}

variable "namespace_3" {
  type = string
  default = "vault"
}

variable "namespace_4" {
  type = string
  default = "harbor"
}