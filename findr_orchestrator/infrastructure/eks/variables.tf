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

variable "eks_node_instance_types_1" {
  description = "instance types"
  type        = string
  default     = null
  sensitive   = true
}

variable "eks_node_instance_types_2" {
  description = "instance types"
  type        = string
  default     = null
  sensitive   = true
}