# FINDR Orchestrator
## Introduction
One stop shop to deploy all the required cloud infrastructure and services to make FINDR operational in minutes. This comprehensive setup includes 
- Harbor: An open-source registry that secures artifacts with policies and role-based access control, ensuring images are scanned and free from vulnerabilities.
- Vault: A tool for securely accessing secrets, Vault manages and controls access to tokens, passwords, certificates, API keys, and other secrets in modern computing.
- Flux: A GitOps toolkit for Kubernetes, ensuring that the state of your clusters matches the configuration in git and automatically updates when there's any change.
- M&M: An In-House Monitoring and Management Stack
Each of these services plays a crucial role and together, these tools integrate seamlessly to provide a robust and secure FINDR platform.

## Prerequisites
- AWS CLI configured with appropriate permissions.
- Terraform, Terragrunt and Helm installed on your local machine.
- Basic knowledge of Terraform, Terragrunt, Helm, Kubernetes, and AWS.

## Configuration Files
- `main.tf`: The main Terraform configuration file for deploying the FINDR Orchestrator.
- `variables.tf`: Contains all the variables used in the Terraform configuration, allowing for customization.
- `outputs.tf`: Defines the outputs of the Terraform configuration, such as service endpoints and access keys.
- `terragrunt.hcl`: Terragrunt configuration file for additional infrastructure management capabilities.

## Setup and Deployment

### Step 1: Initialization
Uncomment source = "./main.tf" in terragrunt.hcl
create terraform.tfvars & findr.tfvars files with the required variables to pass at runtime
*** Don't commit these files to any repositories ***
Run the following command in your terminal to initialize Terraform and download the required providers:

```shell
terraform init
```

### Step 2: Plan Deployment
Execute the following command to preview the actions Terraform will perform:

```shell
terraform plan -var-file="findr.tfvars"
```

### Step 3: Apply Configuration
Apply the Terraform configuration to deploy Harbor:

```shell
terraform apply -var-file="findr.tfvars"
```

### Step 4: Deploy individual services
- Follow service specific readme for seameless deployment.
- After successful deployment, the FINDR app is ready to use and will be accessible through the provided URL.

## Customization
You can customize the deployment by modifying the `main.tf`, `variables.tf`, `outputs.tf`, and `terragrunt.hcl` files. This includes changing settings and configurations to meet specific requirements.

## Notes
- This script deploys Harbor with a LoadBalancer service. Ensure your EKS cluster can provision LoadBalancers.
- Always review and test Terraform scripts in a development environment before applying them in production.