/*
Terraform configurations for all findr clusters.
*/

locals {
  eks_vars = jsondecode(read_tfvars_file("./eks-clusters.tfvars"))
}

##EKS module
##findr-utilities
module "eks_cluster" {
  source                                       = "git@github.com:DISHDevEx/iot.git//aws/modules/eks_cluster"
  flag_use_existing_vpc                        = true
  existing_vpc_id                              = locals.eks_vars.existing_vpc_id
  flag_use_existing_subnet                     = true
  existing_subnet_ids                          = locals.eks_vars.existing_subnet_ids
  flag_use_existing_subnet_route_table         = true
  existing_subnet_route_table_id               = locals.eks_vars.existing_subnet_route_table_id
  flag_use_existing_eks_execution_role         = true
  existing_eks_iam_role_arn                    = locals.eks_vars.existing_eks_iam_role_arn
  flag_use_existing_node_group_role            = true
  existing_node_group_iam_role_arn             = locals.eks_vars.existing_node_group_iam_role_arn
  eks_cluster_name                             = locals.eks_vars.eks_cluster_name_1
  eks_node_group_name                          = locals.eks_vars.eks_node_group_name_1
  eks_node_capacity_type                       = "ON_DEMAND"
  eks_node_instance_types                      = [locals.eks_vars.eks_node_instance_types]
  eks_node_desired_size                        = 1
  eks_node_max_size                            = 3
  eks_node_min_size                            = 1
  eks_node_max_unavailable                     = 1
}

##findr-orchestrator
module "eks_cluster" {
  source                                       = "git@github.com:DISHDevEx/iot.git//aws/modules/eks_cluster"
  flag_use_existing_vpc                        = true
  existing_vpc_id                              = locals.eks_vars.existing_vpc_id
  flag_use_existing_subnet                     = true
  existing_subnet_ids                          = locals.eks_vars.existing_subnet_ids
  flag_use_existing_subnet_route_table         = true
  existing_subnet_route_table_id               = locals.eks_vars.existing_subnet_route_table_id
  flag_use_existing_eks_execution_role         = true
  existing_eks_iam_role_arn                    = locals.eks_vars.existing_eks_iam_role_arn
  flag_use_existing_node_group_role            = true
  existing_node_group_iam_role_arn             = locals.eks_vars.existing_node_group_iam_role_arn
  eks_cluster_name                             = locals.eks_vars.eks_cluster_name_2
  eks_node_group_name                          = locals.eks_vars.eks_node_group_name_2
  eks_node_capacity_type                       = "ON_DEMAND"
  eks_node_instance_types                      = [locals.eks_vars.eks_node_instance_types]
  eks_node_desired_size                        = 1
  eks_node_max_size                            = 3
  eks_node_min_size                            = 1
  eks_node_max_unavailable                     = 1
}

##findr-edge
module "eks_cluster" {
  source                                       = "git@github.com:DISHDevEx/iot.git//aws/modules/eks_cluster"
  flag_use_existing_vpc                        = true
  existing_vpc_id                              = locals.eks_vars.existing_vpc_id
  flag_use_existing_subnet                     = true
  existing_subnet_ids                          = locals.eks_vars.existing_subnet_ids
  flag_use_existing_subnet_route_table         = true
  existing_subnet_route_table_id               = locals.eks_vars.existing_subnet_route_table_id
  flag_use_existing_eks_execution_role         = true
  existing_eks_iam_role_arn                    = locals.eks_vars.existing_eks_iam_role_arn
  flag_use_existing_node_group_role            = true
  existing_node_group_iam_role_arn             = locals.eks_vars.existing_node_group_iam_role_arn
  eks_cluster_name                             = locals.eks_vars.eks_cluster_name_3
  eks_node_group_name                          = locals.eks_vars.eks_node_group_name_3
  eks_node_capacity_type                       = "ON_DEMAND"
  eks_node_instance_types                      = [locals.eks_vars.eks_node_instance_types]
  eks_node_desired_size                        = 1
  eks_node_max_size                            = 3
  eks_node_min_size                            = 1
  eks_node_max_unavailable                     = 1
}