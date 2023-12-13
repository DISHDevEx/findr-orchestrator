/**
 * The storage type used for Prometheus data (e.g. s3)
*/
variable "storage_type" {

  type = string

  default = "s3"
}

/** 
 * The name of the S3 bucket to store Prometheus data
*/
variable "bucket_name" {

  type = string

  default = "dish-findr"
}

/**
 * The endpoint URL of the S3 compatible storage
*/ 
variable "s3_endpoint" {

  type = string

  default = "s3://dish-findr"
}

/**
 * Prefix path inside S3 bucket for Prometheus data
*/
variable "prefix" {

  type = string

  default = "monitoring/iot-findr"
}

/**
 * The Kubernetes cluster monitored by Prometheus
*/
variable "cluster_name" {

  description = "The Kubernetes cluster where M&M is deployed"

  type = string

  default = "iot-findr"

}

/**
 * The Kubernetes cluster monitored by Prometheus
*/
variable "monitoring_namespace" {

  description = "The Namespace where M&M is deployed"

  type = string

  default = "monitoring"

}