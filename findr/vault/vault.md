
# Terraform Script for Deploying Vault on EKS

## Overview
This Terraform script deploys [HashiCorp Vault](https://www.vaultproject.io/), a tool for managing secrets, on an existing Amazon EKS cluster using Helm. Vault secures, stores, and tightly controls access to tokens, passwords, certificates, and other sensitive data using UI, CLI, or HTTP API.

## Prerequisites
- An existing Amazon EKS cluster.
- AWS CLI configured with appropriate permissions.
- Terraform and Helm installed on your local machine.
- Basic knowledge of Terraform, Helm, Kubernetes, and AWS.

## Configuration Files
- `main.tf`: The main Terraform configuration file for deploying Vault using the Helm chart.
- `outputs.tf`: Defines the outputs of the Terraform configuration, such as the Vault service endpoint.

## Setup and Deployment

### Step 1: Initialization
Uncomment source = "./vault/main.tf" in terragrunt.hcl
Update local kubectl config file

```shell
aws eks --region us-east-1 update-kubeconfig --name findr-utilities
kubectl create namespace vault
```

Run the following command in your terminal to initialize Terraform and download the required providers:

```shell
terraform init
```

### Step 2: Plan Deployment
Execute the following command to preview the actions Terraform will perform:

```shell
terraform plan
```

### Step 3: Apply Configuration
Apply the Terraform configuration to deploy Vault:

```shell
terraform apply
```

### Step 4: Access Vault
After deployment, the Vault UI can be accessed via the endpoint provided in the Terraform output.

## Customization
You can customize the Vault deployment by modifying the `main.tf` and `outputs.tf` files. This includes changing the Vault Helm chart settings in `main.tf`, and adjusting the output configurations in `outputs.tf`.

## Notes
- This script deploys Vault in a standard configuration. Ensure your EKS cluster can support the deployment.
- Always review and test Terraform scripts in a development environment before applying them in production.
