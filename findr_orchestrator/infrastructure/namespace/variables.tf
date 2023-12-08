/**
 * The name of the Kubernetes cluster
*/
variable "cluster_name" {
  type    = string
  default = "iot-findr-orchestrator"
}


/**
 * Namespace for orchestrator services
*/
variable "namespace_1" {
  type    = string
  default = "orchestrator"
}


/** 
 * Namespace for monitoring services
*/
variable "namespace_2" {
  type    = string 
  default = "monitoring"
}


/**
 * Namespace for Vault services
*/
variable "namespace_3" {
  type    = string
  default = "vault"  
}


/**
 * Namespace for Harbor registry
*/
variable "namespace_4" {
  type    = string
  default = "harbor"
}
