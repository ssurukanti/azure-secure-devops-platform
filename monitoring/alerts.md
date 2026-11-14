# Azure Monitor alerts (suggested)

- **AKS node CPU > 80% for 15 min** — scale or investigate
- **App Service HTTP 5xx > 10 in 5 min** — check Front Door origin health
- **Key Vault secret near expiry (30 days)** — rotate, see `scripts/`
- **Front Door origin latency p95 > 2s** — check origin region / health

Create these in the portal or with Terraform `azurerm_monitor_metric_alert`
once the platform is deployed — they are intentionally not hard-coded here
so the demo stays small.
