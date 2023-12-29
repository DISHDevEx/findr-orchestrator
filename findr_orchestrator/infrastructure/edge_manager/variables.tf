/**
 * The Kubernetes region where ui will be deployed
*/
variable "aws_region" {

  /**
   * Description of aws region
   */
  description = "Default region"

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
  description = "The Kubernetes cluster where orchestrator is deployed"

  /**
   * Variable type
   */
  type = string

  /**
   * Default cluster name
   */ 
  default = "iot-findr-edge"

}

variable "namespace" {
  description = "The namespace in which to create the service account and associated resources."
  type        = string
  default     = "findr"
}
