/**
 * The Kubernetes namespace where oracle will be deployed
*/
variable "oracle_namespace" {

  /**
   * Description of Kubernetes namespace
   */
  description = "The Kubernetes namespace where oracle is deployed"

  /**
   * Variable type
   */
  type = string

  /**
   * Default oracle namespace
   */ 
  default = "oracle"

}

/**
 * The Kubernetes region where oracle will be deployed
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
 * The Kubernetes cluter name where oracle will be deployed
*/
variable "cluster_name" {

  /**
   * Description of what the cluster name is used for
   */
  description = "The Kubernetes cluster where oracle is deployed"

  /**
   * Variable type
   */
  type = string

  /**
   * Default cluster name
   */ 
  default = "iot-findr"

}