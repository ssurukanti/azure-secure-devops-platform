# Azure Secure DevOps Platform - Terraform Project

This project provisions a secure Azure landing zone and DevOps platform using Terraform modules. It creates a resource group, virtual network, Log Analytics workspace, Application Insights, Key Vault, AKS cluster, App Service, and Azure Front Door.

## Project overview

The environment is designed for a demo or proof-of-concept deployment and includes:

- Azure Resource Group
- Virtual Network and subnets
- Azure Log Analytics workspace
- Azure Application Insights connected to Log Analytics for app telemetry and logs
- Azure Key Vault
- AKS cluster with monitoring enabled
- Azure App Service for web workloads with App Insights configured
- Azure Front Door for public routing and origin management

## Directory layout

- `main.tf` - project composition and module wiring
- `variables.tf` - project-level variables
- `outputs.tf` - project-level outputs
- `providers.tf` - Terraform provider setup
- `tfvars/terraform-dev.tfvars` - environment-specific values
- `../modules/` - reusable Terraform modules including `appinsights`

## Prerequisites

Before running locally, ensure you have:

- Terraform >= 1.5
- Azure CLI installed and logged in
- Access to an Azure subscription

Run:

```bash
az login
```

## Local Terraform commands

From the project folder, run the following preflight checks before deployment:

```bash
cd terraform/project

# 1) Set the Azure subscription to use
az account set --subscription "<subscription-id-or-name>"

# 2) Format all Terraform files recursively
terraform fmt -recursive

# 3) Remove stale local plan files
find . -name "*.tfplan" -delete

# 4) Check if the remote state storage account exists (only if using Azure remote state)
az storage account show \
  --name "<storage-account-name>" \
  --resource-group "<state-resource-group>" \
  --query "name" -o tsv

# 5) Initialize Terraform and validate configuration
terraform init
terraform validate
```

If you are using Azure remote state, make sure the storage account exists before running `terraform init` and `terraform plan`.

Once the checks pass:

```bash
cd terraform/project
terraform plan -var-file="./tfvars/terraform-dev.tfvars"
terraform apply -var-file="./tfvars/terraform-dev.tfvars"
```

To destroy the environment:

```bash
cd terraform/project
terraform destroy -var-file="./tfvars/terraform-dev.tfvars"
```

## Example variable file

The file `tfvars/terraform-dev.tfvars` contains the values for this environment. Update it before deployment.

Example:

```hcl
project        = "secure-platform"
environment    = "dev"
location       = "Central US"
aks_node_count = 2
aks_node_size  = "Standard_B2s"
```

## Notes

- Do not commit real Terraform variable files to source control.
- Review cost before applying the AKS and Front Door resources.
- Use `terraform plan` before `terraform apply` to validate configuration changes.
