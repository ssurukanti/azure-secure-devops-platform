# Security decisions

- **Front Door only:** App Service should accept traffic only from Front Door.
  In production, enforce this with an IP restriction that checks the
  `x-fdid` / `X-Azure-FDID` header against your Front Door ID, plus
  Front Door's managed rules. This repo documents the pattern; it does
  not hard-code a Front Door ID.
- **No public AKS API:** the cluster uses a system-assigned identity and
  Azure Monitor logging. For prod, add private cluster + Azure RBAC.
- **RBAC, not access policies:** Key Vault uses `enable_rbac_authorization = true`.
- **No secrets in git:** `.gitignore` blocks `*.tfvars`, `*.tfstate`, `*.pem`.
  GitHub Actions uses secrets (`ARM_*`), never committed values.
- **Least privilege in Vault:** `vault/policies/app-policy.hcl` allows the
  demo app to read only its own secrets.
- **These are 2025-era fixes, generalized:** IP restrictions, managed-rule
  hardening, and permission fixes (for example Databricks folder-level
  permissions, where `/workspace` is the root and cannot take a folder
  permission) are described as patterns here, with no customer, team,
  app, or vulnerability details.
