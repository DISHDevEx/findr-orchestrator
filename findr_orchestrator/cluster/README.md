# Terraform Script for Deploying EKS Cluster
## Setup and Deployment

## Creating Cluster
### Step 1: Initialization
Create terraform.tfvars & findr.tfvars files with the required variables to pass at runtime
*** Don't commit these files to any repositories ***
Run the following command in your terminal to create a .hcl with required source and initialize Terraform and download the required providers:

```shell
terragrunt init
```

### Step 2: Plan Deployment
Execute the following command to preview the actions Terraform will perform:

```shell
terragrunt plan -var-file="./findr.tfvars"
```

### Step 3: Apply Configuration
Apply the Terraform configuration to deploy Harbor:

```shell
terragrunt apply -var-file="./findr.tfvars"
```
