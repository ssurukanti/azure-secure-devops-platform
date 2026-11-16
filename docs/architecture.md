# Architecture

## Why this shape

- **Front Door first:** one public entry point, WAF/managed rules, TLS offload.
  App Service and AKS are not directly internet-facing.
- **Manual first, then Terraform:** Front Door routes/origins were first
  validated by hand in a dev environment, then codified in
  `terraform/modules/frontdoor` — the same manual-first-then-Terraform
  pattern that avoids drift.
- **Secrets in two places, for two jobs:** Azure Key Vault for Azure-native
  secrets, HashiCorp Vault for dynamic / application secrets.
- **Small by default:** B-series AKS nodes, B1 App Service, 30-day log
  retention. Scale up in `terraform/project/tfvars/terraform-dev.tfvars`, not in the modules.

## Diagram

See the Mermaid diagram in the root README.
