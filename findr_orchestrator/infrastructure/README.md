# Terraform Script for Deploying FINDR infrastructure
### Step 1: Initialization

Create terraform.tfvars & findr.tfvars files with the required variables in infrastructure folder
*** Don't commit these files to any repositories ***

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
Apply the Terraform configuration to deploy Harbor:

```shell
terragrunt apply -var-file="./findr.tfvars"
```
