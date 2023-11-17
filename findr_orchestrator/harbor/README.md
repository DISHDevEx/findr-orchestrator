
# Terraform Script for Deploying Harbor on EKS

## Overview
This Terraform script deploys [Harbor](https://goharbor.io/), an open-source container registry, on an existing Amazon EKS cluster using Helm. Harbor provides a trusted cloud-native registry project that stores, signs, and scans content. This setup is ideal for users looking to integrate a container registry into their Kubernetes cluster on AWS.

## Prerequisites
- An existing Amazon EKS cluster.
- AWS CLI configured with appropriate permissions.
- Terraform, Terragrunt and Helm installed on your local machine.
- Basic knowledge of Terraform, Terragrunt, Helm, Kubernetes, and AWS.

## Configuration Files
- `main.tf`: The main Terraform configuration file for deploying Harbor using the Helm chart.
- `outputs.tf`: Defines the outputs of the Terraform configuration, such as the Harbor service endpoint.

## Setup and Deployment

### Step 1: Initialization
Uncomment source = "./findr_orchestrator/harbor/main.tf" in terragrunt.hcl
Update local kubectl config file

```shell
aws eks --region us-east-1 update-kubeconfig --name findr-utilities
kubectl create namespace harbor
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
Apply the Terraform configuration to deploy Harbor:

```shell
terraform apply
```

### Step 4: Access Harbor
After deployment, the Harbor UI can be accessed via the endpoint provided in the Terraform output.

## Customization
You can customize the Harbor deployment by modifying the `main.tf` and `outputs.tf` files. This includes changing the Harbor Helm chart settings in `main.tf`, and adjusting the output configurations in `outputs.tf`.

## Notes
- This script deploys Harbor with a LoadBalancer service. Ensure your EKS cluster can provision LoadBalancers.
- Always review and test Terraform scripts in a development environment before applying them in production.