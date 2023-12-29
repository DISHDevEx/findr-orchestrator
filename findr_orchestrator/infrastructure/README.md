
# Terraform Script for Deploying FINDR Infrastructure

This documentation outlines the steps to use Terragrunt & Terraform for deploying the FINDR infrastructure. It includes initializing the environment, planning, and applying the Terragrunt & Terraform configuration.

## Structure of the Infrastructure Directory

The `infrastructure` folder contains Terraform scripts for EKS Cluster, S3 bucker, Apollo, Harbor, Monitoring, Namespace, Oracle, Orchestrator-api, UI & Vault. 
Each component has its own set of Terraform files (`main.tf`, `variables.tf`, `outputs.tf`) for configuration.

## Prerequisites

- Install Terraform and Terragrunt per your machine
- Install AWS CLI by following the instructions mentioned on this page and ensure to configure the respective account credentials

## EKS and S3 resources Deployment

### Step 1: Initialization

First, create `terraform.tfvars` and `findr.tfvars` files using .example.tfvars files in the `infrastructure` folder. Ensure not to commit these files to any repositories for security reasons.

Navigate to the infrastructure directory and initialize Terragrunt:

```shell
cd findr_orchestrator/infrastructure
terraform init
```

### Step 2: Plan Deployment
Execute the following command to preview the actions Terraform will perform:

```shell
terraform plan -var-file="./findr.tfvars"
```

### Step 3: Apply Configuration
Apply the Terraform configuration to deploy EKS cluster and s3 bucket:

```shell
terraform apply -var-file="./findr.tfvars"
```


## Deployment of FINDR microservices

Update your local kubectl config file to address cluster named iot-findr:

```shell
aws eks --region us-east-1 update-kubeconfig --name iot-findr
aws eks --region us-east-1 describe-cluster --name iot-findr --query cluster.status
```
Start with creating namespaces for findr microservices

### Step 1: Initialization

Navigate to the required microservice folder in infrastructure directory and initialize terraform:

```shell
cd findr_orchestrator/infrastructure/<microservice_folder>
terraform init
```

### Step 2: Plan Deployment
Execute the following command tkubeco preview the actions Terraform will perform:

```shell
terraform plan
```

### Step 3: Apply Configuration
Apply the Terraform configuration to deploy required services:

```shell
terraform apply
```
