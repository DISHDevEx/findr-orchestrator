/**
 * The Kubernetes namespace where ui will be deployed
*/
variable "ui_namespace" {

  /**
   * Description of Kubernetes namespace
   */
  description = "The Kubernetes namespace where ui is deployed"

  /**
   * Variable type
   */
  type = string

  /**
   * Default ui namespace
   */ 
  default = "ui"

}

/**
 * The Kubernetes region where ui will be deployed
*/
variable "aws_region" {

  /**
   * Description of aws region
   */
  description = ""

  /**
   * Variable type
   */
  type = string

  /**
   * Default aws region
   */ 
  default = "us-east-1"

}

/**
 * The Kubernetes cluter name where ui will be deployed
*/
variable "cluster_name" {

  /**
   * Description of what the cluster name is used for
   */
  description = "The Kubernetes cluster where ui is deployed"

  /**
   * Variable type
   */
  type = string

  /**
   * Default cluster name
   */ 
  default = "iot-findr"

}