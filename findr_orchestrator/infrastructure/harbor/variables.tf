/**
 * The Kubernetes namespace where Harbor will be deployed
*/
variable "harbor_namespace" {

  description = "The Kubernetes namespace where Harbor is deployed"

  type = string

  default = "harbor"

}


/**
 * Password for the main Harbor admin user
*/ 
variable "harbor_password" {

  description = "Password for harbor"

  type = string

  default = "harbor"

}


/**
 * TLS auto common name
*/
variable "tls_auto_common_name" {

  description = "tls auto common name"

  type = string

  default = "harbor.findr.com"

}
