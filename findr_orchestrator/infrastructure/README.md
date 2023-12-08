
# Terraform Script for Deploying FINDR Infrastructure

This documentation outlines the steps to use Terragrunt & Terraform for deploying the FINDR infrastructure. It includes initializing the environment, planning, and applying the Terragrunt & Terraform configuration.

## Structure of the Infrastructure Directory

The `infrastructure` folder contains Terraform scripts for EKS Cluster, S3 bucker, Apollo, Harbor, Monitoring, Namespace, Oracle, Orchestrator-api, UI & Vault. 
Each component has its own set of Terraform files (`main.tf`, `variables.tf`, `outputs.tf`) for configuration.

## Prerequisites

Before proceeding, ensure you have Terraform and Terragrunt installed on your system.

## Deployment EKS and S3 resources

### Step 1: Initialization

First, create `terraform.tfvars` and `findr.tfvars` files using .example.tfvars files in the `infrastructure` folder. Ensure not to commit these files to any repositories for security reasons.

Navigate to the infrastructure directory and initialize Terragrunt:

```shell
cd findr_orchestrator/infrastructure
terragrunt init
```

### Step 2: Plan Deployment
Execute the following command to preview the actions Terraform will perform:

```shell
terragrunt plan -var-file="./findr.tfvars"
```

### Step 3: Apply Configuration
Apply the Terraform configuration to deploy EKS cluster and s3 bucket:

```shell
terragrunt apply -var-file="./findr.tfvars"
```

## Deployment of FINDR microservices

### Step 1: Initialization

Navigate to the required microservice folder in infrastructure directory and initialize terragrunt:

```shell
cd findr_orchestrator/<microservice_folder>
terraform init
```

### Step 2: Plan Deployment
Execute the following command to preview the actions Terraform will perform:

```shell
terraform plan
```

### Step 3: Apply Configuration
Apply the Terraform configuration to deploy required services

```shell
terraform apply
```
