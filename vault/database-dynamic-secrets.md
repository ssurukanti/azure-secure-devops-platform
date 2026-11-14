# Vault dynamic secrets (example)

Instead of a long-lived database password in Key Vault, Vault can mint
a short-lived credential on demand:

```bash
# Dev Vault only
vault write database/config/demo-db \
  plugin_name=postgresql-database-plugin \
  connection_url="postgresql://{{username}}:{{password}}@db.example.com:5432/demo" \
  allowed_roles="demo-app"

vault write database/roles/demo-app \
  db_name=demo-db \
  creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
  default_ttl="1h" max_ttl="24h"

# The app reads a fresh credential each time — no static password to rotate.
vault read database/creds/demo-app
```

See `policies/app-policy.hcl` for the least-privilege policy that allows this.
