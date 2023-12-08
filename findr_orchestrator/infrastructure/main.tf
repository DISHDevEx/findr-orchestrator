/*
Terraform configurations for all findr clusters.
*/

##EKS module
##findr-orchestrator
module "findr" {
  source                                       = "git@github.com:DISHDevEx/iot.git//aws/modules/eks_cluster"
  flag_use_existing_vpc                        = true
  existing_vpc_id                              = var.existing_vpc_id
  flag_use_existing_subnet                     = true
  existing_subnet_ids                          = [var.existing_subnet_ids_1,var.existing_subnet_ids_2]
  flag_use_existing_subnet_route_table         = true
  existing_subnet_route_table_id               = var.existing_subnet_route_table_id
  flag_use_existing_eks_execution_role         = true
  existing_eks_iam_role_arn                    = var.existing_eks_iam_role_arn
  flag_use_existing_node_group_role            = true
  existing_node_group_iam_role_arn             = var.existing_node_group_iam_role_arn
  eks_cluster_name                             = var.eks_cluster_name_1
  eks_node_group_name                          = var.eks_node_group_name_1
  eks_node_capacity_type                       = "ON_DEMAND"
  eks_node_instance_types                      = [var.eks_node_instance_types_1]
  eks_node_desired_size                        = 2
  eks_node_max_size                            = 3
  eks_node_min_size                            = 1
  eks_node_max_unavailable                     = 1
}

##findr-edge
module "findr-edge" {
  source                                       = "git@github.com:DISHDevEx/iot.git//aws/modules/eks_cluster"
  flag_use_existing_vpc                        = true
  existing_vpc_id                              = var.existing_vpc_id
  flag_use_existing_subnet                     = true
  existing_subnet_ids                          = [var.existing_subnet_ids_1,var.existing_subnet_ids_2]
  flag_use_existing_subnet_route_table         = true
  existing_subnet_route_table_id               = var.existing_subnet_route_table_id
  flag_use_existing_eks_execution_role         = true
  existing_eks_iam_role_arn                    = var.existing_eks_iam_role_arn
  flag_use_existing_node_group_role            = true
  existing_node_group_iam_role_arn             = var.existing_node_group_iam_role_arn
  eks_cluster_name                             = var.eks_cluster_name_2
  eks_node_group_name                          = var.eks_node_group_name_2
  eks_node_capacity_type                       = "ON_DEMAND"
  eks_node_instance_types                      = [var.eks_node_instance_types_2]
  eks_node_desired_size                        = 2
  eks_node_max_size                            = 3
  eks_node_min_size                            = 1
  eks_node_max_unavailable                     = 1
}

module "namespace" {
  source       = "./namespace/main.tf"
}

module "monitoring" {
  source       = "./monitoring/main.tf"
}

module "vault" {
  source       = "./vault/main.tf"
}

module "harbor" {
   source       = "./harbor/main.tf"
}
