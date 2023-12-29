/**
 * The Kubernetes namespace where ui will be deployed
*/
variable "namespace" {

  /**
   * Description of Kubernetes namespace
   */
  description = "The Kubernetes namespace where orchestrator is deployed"

  /**
   * Variable type
   */
  type = string

  /**
   * Default ui namespace
   */ 
  default = "orchestrator"

}

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
  default = "iot-findr"

}

/**
 * Vault Address
*/
variable "vault_address" {

  /**
   * Vault url
   */
  description = "Vault Url"

  /**
   * Variable type
   */
  type = string

}

/**
 * Vault Token
*/
variable "vault_token" {

  /**
   * Vault Token
   */
  description = "Vault token"

  /**
   * Variable type
   */
  type = string
}


/**
 * Container Image info
*/
variable "container_image" {

  /**
   * Vault Token
   */
  description = "container image from dockerhub"

  /**
   * Variable type
   */
  type = string

   /**
   * Default container image
   */ 
  default = "docker.io/pravnreddy429/findr_orchestrator:v27"

}

variable "aws_access_key_id" {
  description = "AWS Access key"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "aws_session_token" {
  description = "AWS Session Token"
  type        = string
}




