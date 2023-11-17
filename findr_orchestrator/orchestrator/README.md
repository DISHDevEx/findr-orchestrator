# Terraform Script for Deploying EKS Cluster
## Setup and Deployment

## Creating Cluster
### Step 1: Initialization
Uncomment source = "./findr_orchestrator/orchestrator/cluster/main.tf" in terragrunt.hcl
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

## Creating Namespace
### Step 1: Initialization
Uncomment source = "./findr_orchestrator/orchestrator/namespace/main.tf" in terragrunt.hcl
create terraform.tfvars & findr.tfvars files with the required variables to pass at runtime
*** Don't commit these files to any repositories ***

Update local kubectl config file

```shell
aws eks --region us-east-1 update-kubeconfig --name findr-utilities
```

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

## Creating Pod
Uncomment source = "./findr_orchestrator/orchestrator/pod/main.tf" in terragrunt.hcl
create terraform.tfvars & findr.tfvars files with the required variables to pass at runtime
*** Don't commit these files to any repositories ***

Update local kubectl config file

```shell
aws eks --region us-east-1 update-kubeconfig --name findr-utilities
```

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
