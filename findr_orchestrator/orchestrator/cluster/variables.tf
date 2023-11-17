#Variables for root module
variable "aws_region" {
  description = "AWS region name"
  type        = string
  default     = "us-east-1"
}
variable "aws_access_key" {
  description = "AWS account access key"
  type        = string
  default     = null
  sensitive   = true
}
variable "aws_secret_key" {
  description = "AWS account secret key"
  type        = string
  default     = null
  sensitive   = true
}
variable "aws_session_token" {
  description = "AWS account session token"
  type        = string
  default     = null
  sensitive   = true
}
variable "profile" {
  description = "AWS account - credentials profile name"
  type        = string
  default     = null
  sensitive   = true
}
variable "vault_address" {
  description = "Vault server address"
  type        = string
  default     = null
  sensitive   = true
}
variable "vault_token" {
  description = "Vault server token"
  type        = string
  default     = null
  sensitive   = true
}
variable "vault_secrets_path" {
  description = "Secrets path in Hashicorp Vault"
  type        = string
  default     = null
  sensitive   = true
}
#Backend variables
variable "backend_bucket_name" {
  description = "Backend S3 bucket name to store the Terraform state file"
  type        = string
  default     = null
  sensitive   = true
}
variable "backend_bucket_key" {
  description = "Backend S3 file to store the Terraform state file"
  type        = string
  default     = null
  sensitive   = true
}
variable "backend_dynamodb_table_name" {
  description = "Backend Dynamodb table name to store the Terraform state lock"
  type        = string
  default     = null
  sensitive   = true
}
#findr variables
variable "existing_subnet_route_table_id" {
  description = "route table id"
  type        = string
  default     = null
  sensitive   = true
}
variable "existing_vpc_id" {
  description = "vpc id"
  type        = string
  default     = null
  sensitive   = true
}
variable "existing_subnet_ids_1" {
  description = "subnets 1"
  type        = string
  default     = null
  sensitive   = true
}
variable "existing_subnet_ids_2" {
  description = "subnets 2"
  type        = string
  default     = null
  sensitive   = true
}
variable "existing_eks_iam_role_arn" {
  description = "iam role for eks cluster"
  type        = string
  default     = null
  sensitive   = true
}
variable "existing_node_group_iam_role_arn" {
  description = "iam role for node groups"
  type        = string
  default     = null
  sensitive   = true
}
variable "eks_cluster_name_1" {
  description = "unique cluster name 1"
  type        = string
  default     = null
  sensitive   = true
}
variable "eks_cluster_name_2" {
  description = "unique cluster name 2"
  type        = string
  default     = null
  sensitive   = true
}
variable "eks_cluster_name_3" {
  description = "unique cluster name 3"
  type        = string
  default     = null
  sensitive   = true
}
variable "eks_node_group_name_1" {
  description = "unique node group name 1"
  type        = string
  default     = null
  sensitive   = true
}
variable "eks_node_group_name_2" {
  description = "unique node group name 2"
  type        = string
  default     = null
  sensitive   = true
}
variable "eks_node_group_name_3" {
  description = "unique node group name 3"
  type        = string
  default     = null
  sensitive   = true
}
variable "eks_node_instance_types" {
  description = "instance types"
  type        = string
  default     = null
  sensitive   = true
}