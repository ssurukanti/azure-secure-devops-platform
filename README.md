# Azure Secure DevOps Platform

A demo platform that shows how I build secure, automated Azure infrastructure — the same patterns I use day to day: Terraform modules, AKS, Front Door, Key Vault, HashiCorp Vault, and GitHub Actions CI/CD.

> **Demo only.** This is a portfolio project. It contains no employer code, no real secrets, no subscription IDs, and no internal names. Everything here is generic and safe to run in your own Azure subscription.

## What it builds

```mermaid
flowchart LR
    User --> FD[Azure Front Door]
    FD --> App[App Service / AKS]
    App --> AI[Application Insights]
    AI --> LA[Log Analytics / Azure Monitor]
    App --> KV[Azure Key Vault]
    App --> Vault[HashiCorp Vault]
```

- **Front Door** in front of App Service, with managed rules and IP restrictions
- **AKS** with a demo app, ingress, health checks, and resource limits
- **Application Insights** connected to Log Analytics to surface app logs and telemetry
- **Key Vault** for Azure-native secrets, with RBAC (no access policies)
- **HashiCorp Vault** policies and dynamic-secrets examples (dev Vault only)
- **GitHub Actions**: Terraform plan on PR, apply on merge, `tfsec` scan, Docker build

## Tech stack

Terraform · Azure (AKS, Front Door, App Service, Key Vault, VNet, Log Analytics, Application Insights) · Kubernetes / Helm · Docker · HashiCorp Vault · GitHub Actions · PowerShell · Python

## Quick start

```bash
# 1. Prereqs: Azure CLI, Terraform >= 1.5, kubectl, Docker
az login

# 2. Configure (copy the example, fill in YOUR values — never commit the real one)
cp terraform/project/tfvars/terraform-dev.tfvars.example terraform/project/tfvars/terraform-dev.tfvars

# 3. Deploy the platform
cd terraform/project
terraform init
terraform plan -var-file="./tfvars/terraform-dev.tfvars"
terraform apply -var-file="./tfvars/terraform-dev.tfvars"

# 4. Deploy the demo app to AKS
kubectl apply -f ../../k8s/

# 5. Tear it down when you're done — AKS + Front Door cost money
terraform destroy -var-file="./tfvars/terraform-dev.tfvars"
```

## Repo layout

| Path | What it is |
| --- | --- |
| `terraform/` | Root Terraform folder with the project module and reusable modules (`aks`, `keyvault`, `frontdoor`, `appservice`, `appinsights`, `vnet`, `log-analytics`) |
| `terraform/project/` | Main Terraform project entry point and environment variable file directory (`tfvars/`) |
| `app/` | Tiny demo web app, Dockerized |
| `k8s/` | Kubernetes manifests for the demo app |
| `helm/` | Helm chart for the demo app |
| `.github/workflows/` | Terraform CI/CD + Docker build |
| `vault/` | Vault policies, KV + database dynamic-secrets examples |
| `monitoring/` | Log Analytics queries, Azure Monitor alerts |

| `docs/` | Architecture and security decisions |

## Cost warning
AKS, Front Dor, and App Service are **not free**. Run `terraform plan -var-file="./tfvars/terraform-dev.tfvars"` from `terraform/project` first, check the resources, and run `terraform destroy -var-file="./tfvars/terraform-dev.tfvars"` when you're done experimenting. The default node size is the smallest practical one for a demo — change it in `terraform/project/tfvars/terraform-dev.tfvars` if you need more.

## Security notes

- No secrets are committed. Ever. `.gitignore` blocks `*.tfvars` (except the `.example`), `*.tfstate`, and `*.pem`.
- Front Door is the only public entry point. App Service accepts traffic only from Front Door (via the `x-fdid` header check in `docs/security.md`).
- Vault examples use a local dev Vault. Do not point them at a production Vault without review.

## About me

Sai Kiran Reddy Surukanti — Senior Cloud & DevOps Engineer, St Paul, MN.
LinkedIn: https://www.linkedin.com/in/sai-kiran-reddy-surukanti-65406719b/
