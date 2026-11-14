# Least-privilege policy for the demo app.
# The app may read its own secrets, and nothing else.
path "secret/data/demo-app/*" {
  capabilities = ["read"]
}

path "database/creds/demo-app" {
  capabilities = ["read"]
}
