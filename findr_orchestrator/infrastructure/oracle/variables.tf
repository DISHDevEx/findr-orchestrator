/**
 * The Kubernetes namespace where oracle will be deployed
*/
variable "namespace" {

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

/**
 * The vault url used for vault authentication
*/
variable "vault_url" {

  /**
   * Description of vault url used for vault authentication
   */
  description = "vault url used for vault authentication"

  /**
   * Variable type
   */
  type = string

}

/**
 * The vault token used for vault authentication
*/
variable "vault_token" {

  /**
   * Description of vault token used for vault authentication
   */
  description = "vault token used for vault authentication"

  /**
   * Variable type
   */
  type = string

}

/**
 * The findr orchestrator url
*/
variable "findr_orchestrator_url" {

  /**
   * Description of findr orchestrator url
   */
  description = "where oracle sends api request to"

  /**
   * Variable type
   */
  type = string

}

/**
 * The oracle image url
*/
variable "oracle_image" {

  /**
   * Description of oracle image url
   */
  description = "where oracle image is"

  /**
   * Variable type
   */
  type = string

  /**
   * Default oracle image url
   */
  default = "docker.io/pravnreddy429/findr_oracle:v5"

}