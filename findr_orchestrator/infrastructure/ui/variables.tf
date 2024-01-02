/**
 * The Kubernetes namespace where oracle will be deployed
*/
variable "namespace" {

  /**
   * Description of Kubernetes namespace
   */
  description = "The Kubernetes namespace where ui is deployed"

  /**
   * Variable type
   */
  type = string

  /**
   * Default oracle namespace
   */
  default = "ui"

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
 * The findr orchestrator url
*/
variable "findr_oracle_url" {

  /**
   * Description of findr orchestrator url
   */
  description = "where Ui sends api request"

  /**
   * Variable type
   */
  type = string

}

/**
 * The oracle image url
*/
variable "ui_image" {

  /**
   * Description of oracle image url
   */
  description = "where UI docker image is"

  /**
   * Variable type
   */
  type = string

  /**
   * Default oracle image url
   */
  default = "docker.io/pravnreddy429/findr_ui:latest"

}